#!/bin/bash

sudo pacman -S --needed --noconfirm zed
mkdir -p "$HOME/.config/zed"
cp -u -p ./pkgdefs/zed/settings.json "$HOME/.config/zed/settings.json"
cp -u -p ./pkgdefs/zed/keymap.jsonc "$HOME/.config/zed/keymap.json"
