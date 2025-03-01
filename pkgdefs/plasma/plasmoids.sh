#!/bin/bash

sudo pacman -S --needed --noconfirm arch-update
arch-update --tray --enable
systemctl --user enable --now arch-update.timer
# TODO: `systemctl --user edit --full arch-update.timer` and removeOnUnitActiveSec

TMP=$(mktemp -d)
git clone --depth=1 https://github.com/HimDek/Overview-Widget-for-Plasma.git "$TMP"
make -C "$TMP" overview
kpackagetool6 -t Plasma/Applet -i "$TMP/overview.plasmoid"
rm -rf "$TMP"

# plasma-panel-colorizer
# https://github.com/luisbocanegra/plasma-panel-colorizer

# Koi
# https://github.com/baduhai/Koi

# Kröhnkite
# https://github.com/anametologin/krohnkite

# Sticky Window Snapping
# https://github.com/Flupp/sticky-window-snapping

# Plasma Drawer
# https://github.com/p-connor/plasma-drawer

# Wallhaven Wallpaper Reborn
# https://github.com/Blacksuan19/plasma-wallpaper-wallhaven-reborn
# kpackagetool6 -t Plasma/Wallpaper -i ./package
# TODO: query: Makoto Shinkai,Kimi no Na Wa,The Garden of Words,5 Centimeters Per Second,Studio Ghibli,Nier Automata,Nier,Life is Strange,Wall-E,Bioshock Infinite,Stellar Blade,Firewatch,Transistor,Erased