#!/bin/bash

sudo pacman -S --needed --noconfirm flatpak xdg-desktop-portal-kde

sudo pacman -S --needed --noconfirm flatpak-kcm 

source ./pkgdefs/flatpak/repos.sh
