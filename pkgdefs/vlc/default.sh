#!/bin/bash

# https://wiki.archlinux.org/title/VLC_media_player
sudo pacman -S --needed --noconfirm vlc vlc-plugins-all

paru -S --noconfirm --needed vlc-pause-click-plugin

VLCRC="$HOME/.config/vlc/vlcrc"
mkdir -p "$(dirname "$VLCRC")" && touch "$VLCRC"
crudini --set "$VLCRC" core video-filter pause_click
crudini --set "$VLCRC" core control pause_click
