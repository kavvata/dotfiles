#!/usr/bin/env bash
killall .waybar-wrapped
waybar --config /home/kav/.config/waybar/niri-config.jsonc &
disown
