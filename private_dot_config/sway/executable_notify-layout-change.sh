#!/usr/bin/env sh

while true; do
  swaymsg -t subscribe '["input"]' | while read -r _; do
    layout=$(swaymsg -t get_inputs | jq -r '.[] | select(.type=="keyboard") | .xkb_active_layout_name' | head -n1)
    notify-send "Keyboard Layout" "$layout" --expire-time 800
  done
done
