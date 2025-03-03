#!/bin/bash

sudo pacman -S --needed --noconfirm arch-update
arch-update --tray --enable
systemctl --user enable --now arch-update.timer
# TODO: `systemctl --user edit --full arch-update.timer` and removeOnUnitActiveSec

INSTALLED_APPLETS=$(kpackagetool6 --list --type Plasma/Applet)

if ! echo "$INSTALLED_APPLETS" | grep -q "com.himdek.kde.plasma.overview"; then
    TMP=$(mktemp -d)
    git clone --depth=1 https://github.com/HimDek/Overview-Widget-for-Plasma.git "$TMP"
    kpackagetool6 -t Plasma/Applet -i "$TMP"
    rm -rf "$TMP"
fi

paru -S --noconfirm --needed kwin-scripts-sticky-window-snapping-git
kwriteconfig6 --file kwinrc --group Plugins --key sticky-window-snappingEnabled true

paru -S --noconfirm --needed plasma6-applets-wallhaven-reborn-git
source ./pkgdefs/plasma/extensions/wallheaven.sh

paru -S --noconfirm --needed plasma6-applets-panel-colorizer

paru -S --noconfirm --needed koi

sudo pacman -S --noconfirm --needed kwin-scripts-krohnkite-git
# kwriteconfig6 --file kwinrc --group Plugins --key krohnkiteEnabled true

if ! echo "$INSTALLED_APPLETS" | grep -q "p-connor.plasma-drawer"; then
    TMP=$(mktemp -d)
    git clone --depth=1 https://github.com/p-connor/plasma-drawer.git "$TMP"
    desktoptojson -i "$TMP/metadata.desktop" -o "$TMP/metadata.json"
    kpackagetool6 -t Plasma/Applet -i "$TMP"
    rm -rf "$TMP"
fi

qdbus org.kde.KWin /KWin reconfigure
