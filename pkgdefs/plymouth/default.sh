#!/bin/bash

sudo pacman -S --needed --noconfirm plymouth

sudo pacman -S --needed --noconfirm plymouth-kcm

# Theme
PLYMOUTH_THEME_DIR="/usr/share/plymouth/themes/bgrt-plymouth-theme"
[[ -d "$PLYMOUTH_THEME_DIR" ]] && sudo rm -rf "$PLYMOUTH_THEME_DIR"
TMP=$(mktemp -d)
git clone https://github.com/arvigeus/bgrt-plymouth-theme.git "$TMP"
sudo mv "$TMP" "$PLYMOUTH_THEME_DIR"
sudo rm -rf "$PLYMOUTH_THEME_DIR/.git"
sudo plymouth-set-default-theme -R bgrt-plymouth-theme