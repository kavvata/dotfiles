#!/usr/bin/env sh

options="  Lock
  Sleep
⏾  Hibernate
  Shutdown
  Reboot
  Logout"

chosen=$(printf "%s\n" "$options" | wofi --dmenu --prompt "Power Menu" --cache-file /dev/null --width 150 --height 150 --matching fuzzy --insensitive)

case "$chosen" in
"  Lock")
  hyprlock
  ;;
"  Sleep")
  systemctl suspend
  ;;
"⏾  Hibernate")
  systemctl hibernate
  ;;
"  Shutdown")
  systemctl poweroff
  ;;
"  Reboot")
  systemctl reboot
  ;;
"  Logout")
  ~/.config/kav-scripts/logout.sh
  ;;
*) exit 0 ;;
esac
