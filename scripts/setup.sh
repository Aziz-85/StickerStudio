#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "== StickerStudio setup =="

if ! command -v python3 >/dev/null 2>&1; then
  echo "Python 3 is required. Install it first from https://www.python.org/downloads/ or Homebrew."
  exit 1
fi

python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip wheel setuptools
python -m pip install --upgrade sticker-convert

mkdir -p output

echo ""
echo "Setup complete ✅"
echo "Next:"
echo "  cp .env.example .env"
echo "  open .env"
echo "  ./scripts/convert.sh \"https://t.me/addstickers/Luoist19\" \"Luoist19\""
