#!/bin/bash

sudo pacman -S --needed --noconfirm virt-manager

sudo ufw allow in on virbr0
sudo ufw route allow in on virbr0 out on wlan0
sudo ufw route allow out on virbr0
sudo sysctl net.ipv4.ip_forward=1
echo 'net.ipv4.ip_forward=1' | sudo tee /etc/sysctl.d/99-libvirt.conf