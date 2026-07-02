#!/usr/bin/env bash

TMPFILE=$(mktemp /tmp/ocr-XXXXXX.png)

grim -g "$(slurp)" "$TMPFILE" || {
  rm -f "$TMPFILE"
  exit 1
}

TEXT=$(tesseract "$TMPFILE" stdout 2>/dev/null | sed -e '/^[[:space:]]*$/d' | tr '\n' ' ' | sed 's/[[:space:]]*$//')

rm -f "$TMPFILE"

if [ -z "$TEXT" ]; then
  notify-send "OCR" "No text detected"
  exit 1
fi

echo "$TEXT" | wl-copy

if [ ${#TEXT} -gt 200 ]; then
  notify-send "OCR" "${TEXT:0:200}..."
else
  notify-send "OCR" "$TEXT"
fi
