#!/bin/env bash

detect_wm_wayland() {
    for wm in sway niri weston kwin_wayland gnome-shell; do
        if pgrep -x "$wm" > /dev/null; then
            echo "$wm"
            return
        fi
    done
    echo "Unknown"
}

# Wrapper to choose WM detection method
detect_wm() {
    if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
        detect_wm_wayland
    else
        detect_wm_x11
    fi
}


wm=$(detect_wm)

if [[ $wm == "sway" ]]; then
  swaymsg exit
elif [[ $wm == "niri" ]]; then
  niri msg action quit
else
  hyprctl dispatch exit
fi
