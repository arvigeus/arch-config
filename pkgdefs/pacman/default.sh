#!/bin/bash

source ./pkgdefs/pacman/chaotic_aur.sh
source ./pkgdefs/pacman/aur.sh
source ./pkgdefs/pacman/alph-go.sh

sudo pacman -S --needed --noconfirm pacman-contrib reflector

sudo mkdir -p /etc/xdg/reflector
sudo cp -u -p ./pkgdefs/pacman/reflector.conf /etc/xdg/reflector/reflector.conf

source ./pkgdefs/pacman/hooks.sh

# TODO: Manually install later
#paru -S --needed --noconfirm pacman-static
