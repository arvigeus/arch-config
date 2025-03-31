#!/bin/bash

source ./utils/file.sh

# https://wiki.archlinux.org/title/Gamescope
sudo pacman -S --needed --noconfirm \
    gamescope \
    mangohud lib32-mangohud \
    goverlay \
    seatd

sudo systemctl enable seatd
sudo usermod -aG seat "$USER"
sudo usermod -aG video "$USER"

flatpak install -y flathub org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/24.08

mkdir -p "$HOME/.config/environment.d"
cp -u -p ./pkgdefs/gamescope/env.conf "$HOME/.config/environment.d/gamescope.conf"
systemctl --user daemon-reexec

# Steam Gamescope Session
sudo cp -u -p ./pkgdefs/gamescope/gamescope-session.sh /usr/bin/gamescope-session
sudo chmod +x /usr/bin/gamescope-session
sudo cp -u -p ./pkgdefs/gamescope/steamos-session-select.sh /usr/bin/steamos-session-select
sudo chmod +x /usr/bin/steamos-session-select
sudo cp -u -p ./pkgdefs/gamescope/gamescope.desktop /usr/share/wayland-sessions/gamescope.desktop
sudo cp -u -p ./pkgdefs/gamescope/steam-big-picture.desktop /usr/share/wayland-sessions/steam-big-picture.desktop
sudo setcap 'CAP_SYS_NICE=eip' "$(which gamescope)"
