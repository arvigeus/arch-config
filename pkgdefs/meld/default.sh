#!/bin/bash

sudo pacman -S --needed --noconfirm meld

# dconf dump /org/gnome/meld/ > settings.conf
# dconf reset -f /org/gnome/meld/

dconf load /org/gnome/meld/ < ./pkgdefs/meld/settings.conf