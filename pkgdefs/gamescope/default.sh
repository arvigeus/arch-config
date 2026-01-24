#!/bin/bash

source ./utils/file.sh

# https://wiki.archlinux.org/title/Gamescope
sudo pacman -S --needed --noconfirm \
    gamescope \
    mangohud lib32-mangohud \
    seatd

flatpak install -y flathub io.github.benjamimgois.goverlay

paru -S --noconfirm --needed scopebuddy

sudo systemctl enable seatd
sudo usermod -aG seat "$USER"
sudo usermod -aG video "$USER"

flatpak install -y flathub org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/24.08
flatpak install -y flathub org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/24.08


# For stubborn games: `SteamDeck=1 %command%`
# Enabling it only fixes certain games, but it forces downloading lower resolution textures and etc
# Bazzite has this on by default for all games on `-deck` images
# mkdir -p "$HOME/.config/environment.d"
# cp -u -p ./pkgdefs/gamescope/steamdeck.env.conf "$HOME/.config/environment.d/steamdeck.conf"
# systemctl --user daemon-reexec

source ./pkgdefs/gamescope/session/default.sh
