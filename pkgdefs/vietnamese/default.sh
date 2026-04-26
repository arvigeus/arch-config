#!/bin/bash

sudo pacman -S --needed --noconfirm fcitx5 fcitx5-qt fcitx5-gtk fcitx5-configtool fcitx5-unikey

cp -u -p ./pkgdefs/vietnamese/env.conf "$HOME/.config/environment.d/telex.conf"

# Enable Fcitx 5 in KDE Plasma 6
# System Settings → Keyboard → Virtual Keyboard
# Configure Telex: fcitx5-configtool
# Autostart? cp /usr/share/applications/org.fcitx.Fcitx5.desktop ~/.config/autostart/