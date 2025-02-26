#!/bin/bash

flatpak install -y flathub net.lutris.Lutris
flatpak install -y flathub com.heroicgameslauncher.hgl

# NOTE: Bazzite uses BORE scheduler (https://github.com/firelzrd/bore-scheduler)
sudo pacman -S --needed --noconfirm system76-scheduler
sudo systemctl enable com.system76.Scheduler.service --now