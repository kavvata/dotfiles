#!/usr/bin/env bash
set -euo pipefail

PALETTE=(
  181616 0d0c0c c5c9c5 c8c093 12120f 2d4f67
  c4746e e46876 8a9a7b 87a987 c4b28a e6c384
  8ba4b0 7fb4ca a292a3 938aa9 8ea4a2 7aa89f
  a6a69c c5c9c5
)

echo "Extracting distinct hex colors..."

mapfile -t COLORS < <(
  rg -o -i --no-filename '#(?:[0-9a-f]{3}|[0-9a-f]{6}|[0-9a-f]{8})\b' . |
    sort -u
)

if [[ ${#COLORS[@]} -eq 0 ]]; then
  echo "No hex colors found."
  exit 0
fi

for COLOR in "${COLORS[@]}"; do
  echo "Transforming color $COLOR"

  HEX="${COLOR#\#}"
  HEX="${HEX,,}" # lowercase

  # Remove alpha channel (#RRGGBBAA → #RRGGBB)
  if [[ ${#HEX} -eq 8 ]]; then
    HEX="${HEX:0:6}"
  fi

  # Expand shorthand (#RGB → #RRGGBB)
  if [[ ${#HEX} -eq 3 ]]; then
    HEX="${HEX:0:1}${HEX:0:1}${HEX:1:1}${HEX:1:1}${HEX:2:1}${HEX:2:1}"
  fi

  # Find the closest palette color using Python
  REPLACEMENT=$(
    python3 - "$HEX" "${PALETTE[@]}" <<'PY'
import sys

target = sys.argv[1].lower()
palette = [p.lower() for p in sys.argv[2:]]

def hex_to_rgb(h):
    return tuple(int(h[i:i+2], 16) for i in (0, 2, 4))

tr, tg, tb = hex_to_rgb(target)

best = None
best_dist = float("inf")

for p in palette:
    pr, pg, pb = hex_to_rgb(p)
    dist = (tr - pr)**2 + (tg - pg)**2 + (tb - pb)**2
    if dist < best_dist:
        best_dist = dist
        best = p

print("#" + best.upper())
PY
  )

  echo "  → Replacing $COLOR with $REPLACEMENT"

  # Find files containing the color (case-insensitive, literal match)
  while IFS= read -r FILE; do
    sed -Ei "s/${COLOR}/${REPLACEMENT}/gI" "$FILE"
  done < <(rg -l -i -F -- "$COLOR" .)

done

echo "Color transformation complete."
