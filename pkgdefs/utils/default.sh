#!/bin/bash

# bind: allows dig
sudo pacman -S --needed --noconfirm jq bc evtest whois bind wget less rsync rclone

# wireless device monitoring
sudo pacman -S --needed --noconfirm wavemon