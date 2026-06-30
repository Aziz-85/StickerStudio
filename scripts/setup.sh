#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "== StickerStudio setup =="

if ! command -v python3 >/dev/null 2>&1; then
  echo "Python 3 is required. Install it first from https://www.python.org/downloads/ or Homebrew."
  exit 1
fi

if ! xcode-select -p >/dev/null 2>&1; then
  echo "Installing Apple Command Line Tools..."
  xcode-select --install || true
  echo "After Apple Command Line Tools finish installing, run ./scripts/setup.sh again."
  exit 1
fi

if command -v brew >/dev/null 2>&1; then
  echo "Installing macOS build/media dependencies with Homebrew..."
  brew install pkg-config cython ffmpeg || true
else
  echo "Homebrew was not found."
  echo "Install Homebrew first, then run this setup again:"
  echo '  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
  exit 1
fi

# Prefer Python 3.12 if available because it usually has better wheel coverage on macOS ARM64.
PYTHON_BIN="python3"
if command -v python3.12 >/dev/null 2>&1; then
  PYTHON_BIN="python3.12"
fi

rm -rf .venv
"$PYTHON_BIN" -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip wheel setuptools cython

# Help PyAV find Homebrew FFmpeg/pkg-config on Apple Silicon and Intel.
export PKG_CONFIG_PATH="$(brew --prefix ffmpeg)/lib/pkgconfig:$(brew --prefix)/lib/pkgconfig:${PKG_CONFIG_PATH:-}"
export PATH="$(brew --prefix)/bin:$PATH"

python -m pip install --upgrade sticker-convert

mkdir -p output

echo ""
echo "Setup complete ✅"
echo "Next:"
echo "  cp .env.example .env"
echo "  open .env"
echo "  ./scripts/convert.sh \"https://t.me/addstickers/Luoist19\" \"Luoist19\""
