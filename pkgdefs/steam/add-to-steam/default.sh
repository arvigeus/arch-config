#!/bin/bash

# Based on https://github.com/CachyOS/CachyOS-Handheld

mkdir -p "$HOME/.local/bin/"
cp -u -p ./pkgdefs/steam/add-to-steam/add-to-steam.sh "$HOME/.local/bin/add-to-steam"

mkdir -p "$HOME/.local/share/plasma/kickeractions/"
cp -u -p ./pkgdefs/steam/add-to-steam/KickerAction.desktop "$HOME/.local/share/plasma/kickeractions/steam.desktop"

mkdir -p "$HOME/.local/share/kservices5/ServiceMenus/"
cp -u -p ./pkgdefs/steam/add-to-steam/ServiceMenu.desktop "$HOME/.local/share/kservices5/ServiceMenus/steam.desktop"