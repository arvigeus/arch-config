#!/bin/bash

sudo pacman -S --needed --noconfirm fuse2
flatpak install -y flathub it.mijorus.gearlever

sudo mkdir -p /etc/pacman.d/hooks
sudo cp -u -p ./pkgdefs/appimage/appimage-update.hook /etc/pacman.d/hooks/