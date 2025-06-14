#!/bin/bash

sudo pacman -S --needed --noconfirm ffmpeg mkvtoolnix-cli

sudo pacman -S --needed --noconfirm imagemagick ghostscript

flatpak install -y flathub org.kde.subtitlecomposer

flatpak install -y flathub dev.aunetx.deezer

flatpak install -y flathub org.bunkus.mkvtoolnix-gui
