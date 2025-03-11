#!/bin/bash

sudo pacman -S --needed --noconfirm rofi-wayland

mkdir -p "$HOME/.config/rofi"
cp -u -p ./pkgdefs/rofi/config.rasi "$HOME/.config/rofi/config.rasi"
cp -u -p -r ./pkgdefs/rofi/modes/* "$HOME/.config/rofi/modes/"

source ./pkgdefs/rofi/polkit.sh
