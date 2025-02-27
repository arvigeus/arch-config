#!/bin/bash

sudo pacman -S --needed --noconfirm wofi

source ./pkgdefs/wofi/polkit.sh

mkdir -p "$HOME/.local/bin/"
cp -u -p ./pkgdefs/wofi/menu.sh "$HOME/.local/bin/wofi_menu"