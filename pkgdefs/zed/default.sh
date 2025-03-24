#!/bin/bash

sudo pacman -S --needed --noconfirm zed
mkdir -p "$HOME/.config/zed"
cp -u -p ./pkgdefs/zed/settings.json "$HOME/.config/zed/settings.json"
