#!/usr/bin/env bash
set -euo pipefail

for t in gh ffmpeg pdftotext sqlite3 pandoc shellcheck age zstd cmake \
         pytest ruff mypy python3 node jq rg fd tmux rsync sudo; do
  command -v "$t" >/dev/null || { echo "missing: $t"; exit 1; }
done

python3 -c "import fitz, cairosvg"
python3 -c "from PIL import ImageGrab"
cua-driver --version >/dev/null
command -v Xvnc >/dev/null
ls /opt/playwright/chromium-*/chrome-linux*/chrome >/dev/null
id pn >/dev/null
test "$(id -u pn)" = "1000"
echo SANDBOX-SELFCHECK-OK
