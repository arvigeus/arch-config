#!/bin/bash

source ./utils/file.sh

# https://wiki.archlinux.org/title/Gamescope
sudo pacman -S --needed --noconfirm \
    gamescope \
    mangohud lib32-mangohud \
    goverlay \
    seatd

paru -S --noconfirm --needed scopebuddy

sudo systemctl enable seatd
sudo usermod -aG seat "$USER"
sudo usermod -aG video "$USER"

flatpak install -y flathub org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/24.08

mkdir -p "$HOME/.config/environment.d"
cp -u -p ./pkgdefs/gamescope/env.conf "$HOME/.config/environment.d/gamescope.conf"
systemctl --user daemon-reexec

source ./pkgdefs/gamescope/session/default.sh
