#!/bin/bash
# dragon-quant 一键启动脚本
# 使用方式: source setup_env.sh
#
# 该脚本设置运行 dragon-quant 所需的环境变量
# 建议在每次使用前执行

# ============================================
# 配置区 —— 根据实际情况修改
# ============================================

# 数据目录（SQLite 数据库、缓存、日志等）
# 建议放在本地 SSD 上，避免网络文件系统导致 SQLite I/O 错误
export DQ_DATA_DIR="${DQ_DATA_DIR:-$HOME/dragon-quant-data}"

# PATH 中包含 dragon-quant CLI
export PATH="$HOME/.local/bin:$PATH"

# ============================================
# 自动初始化
# ============================================

# 创建必要目录
mkdir -p "$DQ_DATA_DIR"/{cookies,cache,logs,results,shared}

echo "✅ dragon-quant 环境就绪"
echo "   数据目录: $DQ_DATA_DIR"
echo "   数据库:   $DQ_DATA_DIR/dragon.db"
echo ""
echo "常用命令:"
echo "  dragon-quant scan              # v1 四维扫榜"
echo "  dragon-quant scan_v2 --top 5   # v2 五维识别真龙"
echo "  dragon-quant data cookie-status # 查看 Cookie 状态"
echo ""

# 设置 Cookie 提示
if [ ! -f "$DQ_DATA_DIR/cookies/xueqiu" ] || [ ! -s "$DQ_DATA_DIR/cookies/xueqiu" ]; then
    echo "⚠️  雪球 Cookie 未配置。个股数据依赖雪球 Cookie，请执行："
    echo "   dragon-quant data cookie-fetch                    # 自动获取（需 playwright）"
    echo "   # 或手动设置:"
    echo "   dragon-quant data cookie-set --source xq --cookie 'xq_a_token=...; xq_is_login=1; u=...'"
    echo ""
fi
