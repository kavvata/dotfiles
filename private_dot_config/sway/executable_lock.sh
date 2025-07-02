# /bin/bash

playerctl pause
hyprlock &
sleep 0.5  # assume lock is now showing
exit 0     # return early so swayidle continues
