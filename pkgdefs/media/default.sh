#!/bin/bash

sudo pacman -S --needed --noconfirm yt-dlp ffmpeg mkvtoolnix-cli

sudo pacman -S --needed --noconfirm imagemagick ghostscript

#flatpak install -y flathub io.otsaloma.gaupol

flatpak install -y flathub dev.aunetx.deezer
flatpak install -y flathub org.fooyin.fooyin
#flatpak install -y flathub com.github.neithern.g4music

flatpak install -y flathub org.bunkus.mkvtoolnix-gui

# flatpak install -y flathub com.rafaelmardojai.Blanket

flatpak install -y flathub org.nickvision.tubeconverter

#flatpak install -y flathub com.github.johnfactotum.Foliate
