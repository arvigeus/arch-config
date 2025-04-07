#!/bin/bash

flatpak install -y flathub tv.kodi.Kodi

# Allow using mpv as the default player
sudo flatpak override tv.kodi.Kodi --talk-name=org.freedesktop.Flatpak

mkdir -p "$HOME/.var/app/tv.kodi.Kodi/data/userdata"
cp -u -p ./pkgdefs/kodi/playercorefactory.xml "$HOME/.var/app/tv.kodi.Kodi/data/userdata/playercorefactory.xml"
