# dragon-quant 使用速查表

## 环境就绪（每次新终端执行）
```bash
export DQ_DATA_DIR="$HOME/dragon-quant-data"
mkdir -p "$DQ_DATA_DIR"/{cookies,cache,logs,results,shared}
```

## 雪球 Cookie 配置（个股数据必需）
```bash
# 方式 A：浏览器自动获取（推荐，需要 playwright）
dragon-quant data cookie-fetch

# 方式 B：手动设置
# 1. 浏览器登录 https://xueqiu.com
# 2. F12 → Console 输入 document.cookie → 复制结果
# 3. 粘贴到以下命令：
dragon-quant data cookie-set --source xq --cookie 'xq_a_token=xxx; xq_is_login=1; u=xxx...'

# 查看 Cookie 状态
dragon-quant data cookie-status
```

## v1 四维评分 — 扫榜
```bash
dragon-quant scan --top 5                 # Top 5 龙头
dragon-quant scan --top 25 --workers 4    # Top 25，4 线程并发
dragon-quant scan --force                 # 强制刷新（跳过缓存）
dragon-quant scan --date 20260625         # 查看历史扫描结果
```

## v2 五维「识别真龙」
```bash
dragon-quant scan_v2 --top 5              # Top 5
dragon-quant scan_v2 --force              # 强制刷新
dragon-quant scan_v2 --date 20260625      # 查看历史
```

## 龙头回测 + Web UI
```bash
dragon-quant review --source v2           # 回测 v2 龙头
dragon-quant review --date 20260620 --top 5
dragon-quant review --ui --source v2      # 回测后启动 Web UI
dragon-quant review --ui-only --port 8765 # 只看 UI，不回测
```

## 概念板块黑名单
```bash
dragon-quant blacklist list
dragon-quant blacklist add "次新股"
dragon-quant blacklist remove "次新股"
```

## 数据查询
```bash
dragon-quant data sector                  # 行业板块涨幅榜
dragon-quant data sector --asc            # 跌幅榜
dragon-quant data components --sector 881167  # 板块成分股
dragon-quant data kline --code 600172 --days 20
dragon-quant data quote --code 600172
dragon-quant data batch-quote --codes 600172,000001
```

## 个股量价分析
```bash
dragon-quant vpa --code 600519            # 贵州茅台量价分析
dragon-quant vpa --code 600519 --days 120 # 更长周期
```

## 日志与存储管理
```bash
dragon-quant logs --source v2 tail         # 最新日志
dragon-quant logs --source v2 summary      # 扫描摘要
dragon-quant logs --source v1 query --date 20260625 --level error
dragon-quant storage status
dragon-quant storage size
dragon-quant storage clear --all
```

## 文件说明
- 数据目录：`$DQ_DATA_DIR`（默认 `~/dragon-quant-data/`）
- SQLite 数据库：`$DQ_DATA_DIR/dragon.db`
- 雪球 Cookie：`$DQ_DATA_DIR/cookies/xueqiu`
- 缓存：`$DQ_DATA_DIR/cache/`
- 日志：`$DQ_DATA_DIR/logs/`
- Web UI：`http://localhost:8765`（`review --ui` 启动）
