#!/bin/bash

sudo pacman -S --needed --noconfirm gwenview kamera kdeconnect kwalletmanager systemdgenie merkuro kup arianna kamera

# Utils
sudo pacman -S --needed --noconfirm svgpart markdownpart kio-extras kio-fuse kio-gdrive kio-admin ffmpegthumbs kdegraphics-thumbnailers kimageformats icoutils libheif libavif libjxl libraw qt6-imageformats kimageformats dolphin-plugins

# KDE Connect
sudo ufw allow 1714:1764/tcp
sudo ufw allow 1714:1764/udp
