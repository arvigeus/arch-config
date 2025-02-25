#!/bin/bash

sudo pacman -S --needed --noconfirm shellcheck shfmt
cp -u -p ./pkgdefs/bash/config.sh "$HOME/.bashrc"
