#!/usr/bin/env sh

swaymsg -t subscribe -m '["input"]' | while read -r _; do
  layout=$(swaymsg -t get_inputs | jq -r '.[] | select(.type=="keyboard") | .xkb_active_layout_name' | head -n1)
  [ "$layout" != "$(cat /tmp/sway-layout 2>/dev/null)" ] || continue
  notify-send "Keyboard Layout" "$layout" --expire-time 800
  echo "$layout" > /tmp/sway-layout
done
