# StickerStudio

Private beta terminal tool to convert Telegram sticker packs into WhatsApp-compatible output on macOS.

> Current target: fast personal conversion first. Native macOS app comes later.

## What this beta does

- Installs/uses `sticker-convert`.
- Accepts Telegram sticker pack URLs like `https://t.me/addstickers/Luoist19`.
- Exports WhatsApp-compatible output into `output/`.
- Supports Apple Silicon Macs such as M1/M2/M3/M4.

## Requirements

- macOS
- Python 3
- Internet connection
- A Telegram bot token from `@BotFather` for public Telegram sticker pack downloads.

Why a bot token? Telegram sticker pack downloading through `sticker-convert` requires either a Telegram bot token or Telethon setup.

## First-time setup

```bash
git clone git@github.com:Aziz-85/StickerStudio.git
cd StickerStudio
chmod +x scripts/setup.sh scripts/convert.sh
./scripts/setup.sh
cp .env.example .env
open .env
```

Put your Telegram bot token in `.env`:

```bash
TELEGRAM_TOKEN=123456789:ABC_your_token_here
AUTHOR="Abdulaziz"
```

## Convert one pack

```bash
./scripts/convert.sh "https://t.me/addstickers/Luoist19" "Luoist19"
```

The result will be saved inside:

```bash
output/Luoist19/
```

## Your test links

```bash
./scripts/convert.sh "https://t.me/addstickers/Luoist19" "Luoist19"
./scripts/convert.sh "https://t.me/addstickers/HUDAA11" "HUDAA11"
./scripts/convert.sh "https://t.me/addstickers/IALAA" "IALAA"
```

## Import to iPhone / WhatsApp

After conversion, AirDrop the generated `.wastickers` file or output folder to your iPhone, then open it using a sticker importer app such as Sticker Maker / Sticker.ly and add it to WhatsApp.

## Roadmap

- v0.1 Terminal converter
- v0.2 Better macOS helper script
- v0.3 SwiftUI prototype
- v1.0 Native StickerStudio app
