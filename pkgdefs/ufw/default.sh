#!/bin/bash

sudo pacman -S --needed --noconfirm ufw
sudo systemctl enable ufw --now
sudo ufw allow 1714:1764/tcp
sudo ufw allow 1714:1764/udp
sudo ufw enable
