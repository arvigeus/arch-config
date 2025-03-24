#!/bin/bash

sudo pacman -S --needed --noconfirm rofi-wayland

mkdir -p "$HOME/.config/rofi/modes"
cp -u -p ./pkgdefs/rofi/config.rasi "$HOME/.config/rofi/config.rasi"
cp -u -p -r ./pkgdefs/rofi/modes/* "$HOME/.config/rofi/modes/"
mkdir -p "$HOME/.icons/"
cp -u -p -r ./pkgdefs/rofi/icons/* "$HOME/.icons/"

source ./pkgdefs/rofi/polkit.sh
