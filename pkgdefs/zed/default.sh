#!/bin/bash

sudo pacman -S --needed --noconfirm zed
cp -u -p ./pkgdefs/vscode/settings.json "$HOME/.config/zed/settings.json"
