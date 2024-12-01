#!/bin/env bash

if ! command -v git &> /dev/null; then
  sudo pacman -Sy git --noconfirm --needed
fi

git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -rf paru

paru -Syy
# Absolute path this script is in. /home/user/bin
SRCPATH=`dirname $(readlink -f $0)`

packages=""

while IFS="" read -r p || [ -n "$p" ]
do
  packages+="$p "
done < "$SRCPATH/packages.txt"

paru -S --needed --noconfirm $packages

xdg-user-dirs-update
gsettings set org.gnome.desktop.wm.preferences button-layout ''
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
# gsettings set org.gnome.desktop.interface icon-theme Adwaita
gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark

read -p "Don't forget to configure: tuigreeter, keyboard layouts, waybar components, docker user group and apparmor... (Press any key to finish)"
