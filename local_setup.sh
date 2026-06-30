#!/usr/bin/env bash
# ==============================================================
# dragon-quant 一键安装 & 运行脚本
# 适用于 MacOS / Linux / Windows(WSL/Git Bash)
# ==============================================================
set -e

echo "🐉 dragon-quant 龙头战法量化筛选系统 — 安装向导"
echo "================================================"

# ─── 1. Python 检查 ───
echo ""
echo "📋 [1/5] 检查 Python 环境..."
PYTHON=""
for cmd in python3 python; do
    if command -v $cmd &>/dev/null; then
        VER=$($cmd --version 2>&1 | grep -oP '\d+\.\d+')
        if awk "BEGIN {exit !($VER >= 3.8)}"; then
            PYTHON=$cmd
            echo "  ✅ Python $VER"
            break
        fi
    fi
done
if [ -z "$PYTHON" ]; then
    echo "  ❌ 需要 Python >= 3.8，请先安装 https://python.org"
    exit 1
fi

# ─── 2. pip / playwright ───
echo ""
echo "📦 [2/5] 安装 playwright..."
$PYTHON -m pip install playwright --upgrade -q
$PYTHON -m playwright install chromium 2>&1 | tail -3
echo "  ✅ playwright 就绪"

# ─── 3. 安装 dragon-quant ───
echo ""
echo "📦 [3/5] 安装 dragon-quant..."
cd "$(dirname "$0")"
$PYTHON -m pip install -e . --no-build-isolation 2>&1 | tail -3
echo "  ✅ dragon-quant 安装完成"

# ─── 4. 数据目录 ───
echo ""
echo "📂 [4/5] 设置数据目录..."
DQ_DATA_DIR="${DQ_DATA_DIR:-$HOME/dragon-quant-data}"
mkdir -p "$DQ_DATA_DIR"/{cookies,cache,logs,results,shared}
export DQ_DATA_DIR
echo "  ✅ DQ_DATA_DIR=$DQ_DATA_DIR"

# 写入 shell 配置
PROFILE_FILE="$HOME/.bashrc"
if [ -f "$HOME/.zshrc" ]; then PROFILE_FILE="$HOME/.zshrc"; fi
if ! grep -q "DQ_DATA_DIR" "$PROFILE_FILE" 2>/dev/null; then
    {
        echo ""
        echo "# dragon-quant"
        echo "export DQ_DATA_DIR=\"\$HOME/dragon-quant-data\""
        echo "export PATH=\"\$PATH:\$HOME/.local/bin\""
    } >> "$PROFILE_FILE"
    echo "  ⚡ 已写入 $PROFILE_FILE（下次终端生效）"
fi

# ─── 5. Cookie 配置 ───
echo ""
echo "🍪 [5/5] 雪球 Cookie 配置..."
if [ -f "$DQ_DATA_DIR/cookies/xueqiu" ] && [ -s "$DQ_DATA_DIR/cookies/xueqiu" ]; then
    echo "  ✅ 已有雪球 Cookie"
else
    echo "  ⚠️  需要配置雪球 Cookie（个股数据依赖）"
    echo ""
    echo "  方式 A — 自动获取（推荐）："
    echo "    dragon-quant data cookie-fetch"
    echo ""
    echo "  方式 B — 手动设置："
    echo "    1. 浏览器登录 https://xueqiu.com"
    echo "    2. F12 → 控制台输入: document.cookie"
    echo "    3. 复制完整 Cookie 字符串后执行："
    echo "    dragon-quant data cookie-set --source xq --cookie 'xq_a_token=...; xq_is_login=1; u=...'"
    echo ""
fi

# ─── 完成 ───
echo ""
echo "================================================"
echo "✅ dragon-quant 安装完成！"
echo ""
echo "👉 立即运行扫榜："
echo "   source ~/.bashrc    # 或新开终端"
echo "   dragon-quant scan --top 5      # v1 四维评分"
echo "   dragon-quant scan_v2 --top 5   # v2 五维识别真龙"
echo ""
echo "👉 龙头回测 + Web UI："
echo "   dragon-quant review --ui --source v2"
echo ""
echo "👉 查看完整帮助："
echo "   dragon-quant --help"
echo "================================================"
