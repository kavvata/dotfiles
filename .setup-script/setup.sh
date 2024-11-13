#!/bin/env bash

if ! command -v git &> /dev/null; then
  sudo pacman -Sy git --noconfirm --needed
fi

git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -rf paru


while IFS="" read -r p || [ -n "$p" ]
do
  paru -S --needed --noconfirm "$p"
done < ./packages.txt

xdg-user-dirs-update
gsettings set org.gnome.desktop.wm.preferences button-layout ''
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
# gsettings set org.gnome.desktop.interface icon-theme Adwaita
gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark

read -p "Don't forget to configure: tuigreeter, docker user group and apparmor"
