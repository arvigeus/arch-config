#!/bin/bash

# https://wiki.archlinux.org/title/VLC_media_player
sudo pacman -S --needed --noconfirm vlc vlc-plugins-all

paru -S --noconfirm --needed vlc-pause-click-plugin

VLCRC="$HOME/.config/vlc/vlcrc"
mkdir -p "$(dirname "$VLCRC")" && touch "$VLCRC"
crudini --ini-options=nospace --set "$VLCRC" core video-filter pause_click
crudini --ini-options=nospace --set "$VLCRC" core control pause_click
crudini --ini-options=nospace --set "$VLCRC" core snapshot-path ~/Pictures
crudini --ini-options=nospace --set "$VLCRC" core snapshot-prefix vlc-
crudini --ini-options=nospace --set "$VLCRC" core audio-language jpn,jp,eng,en
crudini --ini-options=nospace --set "$VLCRC" core sub-language eng,en,bg,vi,vn
crudini --ini-options=nospace --set "$VLCRC" core one-instance 1
crudini --ini-options=nospace --set "$VLCRC" core playlist-enqueue 1
crudini --ini-options=nospace --set "$VLCRC" qt qt-minimal-view 1
crudini --ini-options=nospace --set "$VLCRC" qt qt-system-tray 0
crudini --ini-options=nospace --set "$VLCRC" qt qt-pause-minimized 1
crudini --ini-options=nospace --set "$VLCRC" qt qt-dark-palette 1
crudini --ini-options=nospace --set "$VLCRC" qt qt-max-volume 200
#crudini --ini-options=nospace --set "$VLCRC" subsdec subsdec-encoding Windows-1251
