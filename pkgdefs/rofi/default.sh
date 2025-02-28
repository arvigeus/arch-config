#!/bin/bash

sudo pacman -S --needed --noconfirm rofi-wayland

# Theme based on windows11-list-dark.rasi from https://github.com/newmanls/rofi-themes-collection
mkdir -p "$HOME/.local/share/rofi/themes/"
cp -u -p ./pkgdefs/rofi/theme.rasi "$HOME/.local/share/rofi/themes/list-theme.rasi"
mkdir -p "$HOME/.config/rofi"
{
  echo '@theme "'"$HOME/.local/share/rofi/themes/list-theme.rasi"'"'
  echo 'configuration { scroll-method: 1; }'
} > "$HOME/.config/rofi/config.rasi"

source ./pkgdefs/rofi/polkit.sh

mkdir -p "$HOME/.local/bin/"
cp -u -p ./pkgdefs/rofi/menu.sh "$HOME/.local/bin/rofi_menu"