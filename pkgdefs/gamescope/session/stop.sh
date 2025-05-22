#!/bin/sh

steam -shutdown
sudo systemctl stop plugin_loader.service
asusctl profile -P Balanced

# Re-enable internal speakers
default_sink=$(pactl get-default-sink)
pactl set-card-profile alsa_card.pci-0000_07_00.6 output:analog-stereo
[ -n "$default_sink" ] && pactl set-default-sink "$default_sink"