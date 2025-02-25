#!/bin/bash

# https://wiki.archlinux.org/title/Mpv
sudo pacman -S --needed --noconfirm mpv mpv-shim-default-shaders
paru -S --noconfirm --needed mpv-uosc-git mpv-thumbfast-git

mkdir -p "$HOME/.config/mpv"
ln -s /usr/share/mpv-shim-default-shaders/shaders/ "$HOME/.config/mpv"

mkdir -p "$HOME/.config/mpv/scripts/"
if [ ! -f "$HOME/.config/mpv/scripts/osc.lua" ]; then
    # Allow Christmas
    curl -L -o "$HOME/.config/mpv/scripts/osc.lua" "https://raw.githubusercontent.com/christoph-heinrich/sosc/master/osc.lua"
fi

cp -u -p ./pkgdefs/mpv/mpv.conf "$HOME/.config/mpv/mpv.conf"
cp -u -p ./pkgdefs/mpv/input.conf "$HOME/.config/mpv/input.conf"
