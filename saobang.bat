@echo off
chcp 65001 >nul
cd /d C:\Users\28288\Desktop\dragon-quant-main
set PYTHONIOENCODING=utf-8
python -m dragon_quant scan_v2 --top 5
pause
