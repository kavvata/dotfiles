#!/bin/sh

DELIM="__WID__"

WINDOWS=$(niri msg -j windows | jq -r --arg D "$DELIM" '.[] | "   \(.app_id): \(.title)\($D)\(.id)"')

CHOICE=$(echo "$WINDOWS" | sed "s/$DELIM.*//" | wofi --width 300 --height 300 --dmenu --prompt "Select a window:" --matching fuzzy --insensitive)

[ -z "$CHOICE" ] && exit

WIN_ID=$(echo "$WINDOWS" | grep -F "$CHOICE" | sed "s/.*$DELIM//")

niri msg action focus-window --id "$WIN_ID"

# window_list=$(niri msg --json windows)
# name=$(echo $window_list | jq -r '.[] | "\(.app_id): \(.title)"' | fuzzel --dmenu)
# id=$(echo $window_list | jq -r '.[] | ."title", ."id"' | grep "$name" -x -A 1 | grep "$name" -vx)
#
# echo $id
# echo $name
#
# niri msg action focus-window --id $id
