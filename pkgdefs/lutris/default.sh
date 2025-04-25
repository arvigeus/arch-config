#!/bin/bash

flatpak install -y flathub net.lutris.Lutris
# NOTE: 23.08 is not the latest, but it's the most recent version compatible with Lutris.
flatpak install -y flathub org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/23.08
flatpak install -y flathub org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08

mkdir -p "$HOME/.var/app/net.lutris.Lutris/config/MangoHud"
curl -L -o "$HOME/.var/app/net.lutris.Lutris/config/MangoHud/MangoHud.conf" \
    https://raw.githubusercontent.com/flightlessmango/MangoHud/master/data/MangoHud.conf

