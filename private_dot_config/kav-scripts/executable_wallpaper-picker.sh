#!/bin/sh

kitty sh -c 'fd . ~/Pictures/Wallpapers -e jpg -e png -e jpeg -t f \
  | fzf --preview-window=top --preview "kitty +kitten icat --use-window-size 30,20,938,528 --stdin=no --clear --transfer-mode=file {}" --bind "enter:execute-silent(ln -sf {} ~/.wallpaper; ln -sf {} ~/.lockscreen; nohup ~/.config/ml4w/scripts/reload-hyprpaper.sh >/dev/null 2>&1 &)+abort"'
