#!/usr/bin/env bash

niri-layout-monitor() {
  niri msg event-stream | while IFS= read -r line; do
    if [[ "$line" =~ ^"Keyboard layout switched: "[0-9]+$ ]]; then
      local idx="${line##* }"
      local layout
      layout=$(niri msg -j keyboard-layouts | python3 -c "
import sys, json
data = json.load(sys.stdin)
print(data['names'][${idx}])
")
      notify-send -t 1500 "Keyboard Layout" "$layout"
    fi
  done
}

niri-layout-monitor
