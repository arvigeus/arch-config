#!/bin/bash

source ./pkgdefs/pacman/chaotic_aur.sh
source ./pkgdefs/pacman/aur.sh
source ./pkgdefs/pacman/alph-go.sh

sudo pacman -S --needed --noconfirm pacman-contrib reflector

source ./pkgdefs/pacman/hooks.sh

paru -S --needed --noconfirm pacman-static
