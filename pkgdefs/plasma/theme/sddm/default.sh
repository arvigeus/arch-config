#!/bin/bash

paru -S --needed --noconfirm where-is-my-sddm-theme-git

sudo cp -p ./pkgdefs/plasma/theme/sddm/theme.conf /usr/share/sddm/themes/where_is_my_sddm_theme/theme.conf
sudo cp -u -p ./pkgdefs/plasma/theme/sddm/logo.png /usr/share/sddm/themes/where_is_my_sddm_theme/logo.png

sudo mkdir -p /etc/sddm.conf.d
echo -e "[Theme]\nCurrent=where_is_my_sddm_theme" | sudo tee /etc/sddm.conf.d/10-theme.conf
