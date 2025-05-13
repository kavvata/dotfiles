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

echo "Everything is pretty much done. the following steps are for configuring system-space stuff, so you might want to Ctrl-C now." 
read -p "Arch linux is pretty unstable so these configurations might be out-of-date (Press any key to continue or Ctrl-C to stop)"

read -p "(plymouth) Adding and enabling my custom plymouth theme. (Press any key to continue or Ctrl-C to stop)"
sudo cp -R ../plymouth-theme/ascii-think /usr/share/plymouth/themes/
sudo plymouth-set-default-theme -R ascii-think

read -p "(plymouth) Please add plymouth to your hooks (Press any key to open /etc/mkinitcpio.conf or Ctrl-C to stop)"
sudoedit /etc/mkinitcpio.conf

read -p "(docker) Creating a docker group and adding your user to it. (Press any key to continue or Ctrl-C to stop)"
sudo groupadd docker
sudo usermod -aG docker $USER


read -p "(tuigreet) configuring and enabling greetd. (Press any key to continue or Ctrl-C to stop)"
sudo cp ../systemspace-configs/common/etc/greetd/config.toml /etc/greetd/config.toml
sudo systemctl enable greetd


echo "(apparmor) Please add the following to your boot args:"
echo "lsm=landlock,lockdown,yama,integrity,apparmor,bpf"
read -p "Honestly i refuse to touch your boot entry files so i am leaving this up to you (Press any key to continue or Ctrl-C to stop)"


read -p "Don't forget to configure: keyboard layouts, waybar components, etc... (Press any key to finish)"
