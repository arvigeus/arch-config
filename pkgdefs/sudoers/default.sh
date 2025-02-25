#!/bin/bash

sudo usermod -aG wheel arvigeus
sudo rm -rf /etc/sudoers.d/*
echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/00_wheel_nopasswd
sudo chmod 440 /etc/sudoers.d/00_wheel_nopasswd
