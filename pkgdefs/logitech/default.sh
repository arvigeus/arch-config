#!/bin/bash

# sudo pacman -S --needed --noconfirm chaotic-aur/logiops

sudo cp -u -p ./pkgdefs/logitech/logid.cfg /etc/logid.cfg

sudo systemctl enable logid --now

# Use this to debug broken config
# sudo logid -v
