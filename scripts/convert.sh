#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

PACK_URL="${1:-}"
PACK_NAME="${2:-}"

if [[ -z "$PACK_URL" ]]; then
  echo "Usage: ./scripts/convert.sh \"https://t.me/addstickers/PACK_NAME\" \"OutputName\""
  exit 1
fi

if [[ -z "$PACK_NAME" ]]; then
  PACK_NAME="$(basename "$PACK_URL")"
fi

if [[ ! -d ".venv" ]]; then
  echo "Virtual environment not found. Run: ./scripts/setup.sh"
  exit 1
fi

if [[ ! -f ".env" ]]; then
  echo ".env not found. Run: cp .env.example .env then add TELEGRAM_TOKEN."
  exit 1
fi

# Load .env safely enough for simple KEY=VALUE lines
set -a
source .env
set +a

if [[ -z "${TELEGRAM_TOKEN:-}" ]]; then
  echo "Missing TELEGRAM_TOKEN in .env"
  echo "Create a Telegram bot with @BotFather and paste the token into .env"
  exit 1
fi

AUTHOR="${AUTHOR:-Abdulaziz}"
OUT_DIR="$ROOT_DIR/output/$PACK_NAME"
mkdir -p "$OUT_DIR"

source .venv/bin/activate

echo "== StickerStudio v0.1 =="
echo "Pack:   $PACK_URL"
echo "Output: $OUT_DIR"
echo ""

# sticker-convert CLI has changed names/options between versions.
# This wrapper tries the modern module entry first, then falls back to command discovery.
if python -m sticker_convert --help >/dev/null 2>&1; then
  python -m sticker_convert \
    --download-auto "$PACK_URL" \
    --export-whatsapp \
    --output-dir "$OUT_DIR" \
    --telegram-token "$TELEGRAM_TOKEN" \
    --author "$AUTHOR"
elif command -v sticker-convert >/dev/null 2>&1; then
  sticker-convert \
    --download-auto "$PACK_URL" \
    --export-whatsapp \
    --output-dir "$OUT_DIR" \
    --telegram-token "$TELEGRAM_TOKEN" \
    --author "$AUTHOR"
else
  echo "Could not find sticker-convert command after setup."
  echo "Try: source .venv/bin/activate && python -m pip show sticker-convert"
  exit 1
fi

echo ""
echo "Done ✅"
echo "Open output folder:"
echo "open '$OUT_DIR'"
open "$OUT_DIR"
