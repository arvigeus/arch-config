#!/bin/bash

sudo pacman -S --needed --noconfirm meld

# dconf dump /org/gnome/meld/ > settings.conf
# dconf reset -f /org/gnome/meld/

dconf load /org/gnome/meld/ < ./pkgdefs/meld/settings.conf

mkdir -p "$HOME/.config/environment.d"
cp -u -p ./pkgdefs/meld/env.conf "$HOME/.config/environment.d/meld.conf"
systemctl --user daemon-reexec

mkdir -p "$HOME/.config/arch-update"
echo 'DiffProg=meld' >> "$HOME/.config/arch-update/arch-update.conf"
