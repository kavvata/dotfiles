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
