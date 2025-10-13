#!/bin/sh

DELIM="__WID__"

WINDOWS=$(niri msg -j windows | jq -r --arg D "$DELIM" '.[] | "\(.app_id): \(.title)\($D)\(.id)"')

CHOICE=$(echo "$WINDOWS" | sed "s/$DELIM.*//" | wofi --width 600 --length 400 --dmenu --prompt "Select a window:" --matching fuzzy --insensitive)

[ -z "$CHOICE" ] && exit

WIN_ID=$(echo "$WINDOWS" | grep -F "$CHOICE" | sed "s/.*$DELIM//")

niri msg action focus-window --id "$WIN_ID"
