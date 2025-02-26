#!/bin/bash

sudo pacman -S --needed --noconfirm ufw
sudo systemctl enable ufw --now
sudo ufw enable
