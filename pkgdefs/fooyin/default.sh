#!/bin/bash

flatpak install -y flathub org.fooyin.fooyin

mkdir -p "$HOME/.var/app/org.fooyin.fooyin/config/fooyin/"

cp -u -p ./pkgdefs/fooyin/config/fooyin.conf "$HOME/.var/app/org.fooyin.fooyin/config/fooyin/fooyin.conf"
cp -u -p ./pkgdefs/fooyin/config/layout.fyl "$HOME/.var/app/org.fooyin.fooyin/config/fooyin/layout.fyl"

# Alternatives
# - https://mpz-player.org/
# - https://audacious-media-player.org/ (has QT interface option)
# - https://harmonoid.com/ (last commit: 2023)
