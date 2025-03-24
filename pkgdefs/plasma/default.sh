#!/bin/bash

sudo pacman -S --needed --noconfirm gwenview okular kamera kdeconnect partitionmanager kwalletmanager systemdgenie merkuro kup konsave arianna kamera

# Utils
sudo pacman -S --needed --noconfirm svgpart markdownpart kio-extras kio-fuse kio-gdrive kio-admin ffmpegthumbs kdegraphics-thumbnailers kimageformats icoutils libheif libavif libjxl libraw qt6-imageformats kimageformats dolphin-plugins libappindicator-gtk3

# KDE Connect
sudo ufw allow 1714:1764/tcp
sudo ufw allow 1714:1764/udp

# Theme
sudo pacman -S --needed --noconfirm darkly-qt6-git

# Kwin
paru -S --noconfirm --needed kwin-gestures

source ./pkgdefs/plasma/extensions/default.sh

source ./pkgdefs/plasma/config.sh
source ./pkgdefs/plasma/theme.sh
