#!/bin/bash

sudo pacman -S --needed --noconfirm rofi-wayland

source ./pkgdefs/rofi/polkit.sh

mkdir -p "$HOME/.local/bin/"
cp -u -p ./pkgdefs/rofi/menu.sh "$HOME/.local/bin/rofi_menu"