#!/bin/bash

# https://wiki.archlinux.org/title/Visual_Studio_Code
sudo pacman -S --needed --noconfirm code
#paru -S --needed --noconfirm code-features
source ./pkgdefs/vscode/extensions.sh
cp -u -p ./pkgdefs/vscode/settings.json "$HOME/.config/Code - OSS/User/settings.json"