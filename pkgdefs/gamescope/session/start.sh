#!/bin/sh
# set -v
# set -e  # Exit on error

# Enable logging
#exec > ~/gamescope.log 2>&1

# shellcheck disable=SC3045
ulimit -n 524288 || echo "Failed to set ulimit"

sudo systemctl start plugin_loader.service

# Check AMD_BOOST env var
if [ "${AMD_BOOST:-0}" != "1" ]; then
  amd-boost 0
else
  # Cannot set Performance and disable boost at the same time
  asusctl profile -P Performance
fi

# Generally this doesn't work: neither Geamescope session, neither Steam Big Picture
#sudo ryzenadj --tctl-temp=80

# Disable internal speakers
pactl set-card-profile alsa_card.pci-0000_07_00.6 off

switcherooctl launch gamescope \
  --adaptive-sync \
  -e --xwayland-count 2 --default-touch-mode 4 --immediate-flips -F fsr --mangoapp \
  -f --force-grab-cursor \
  -- steam-native -steamos3 -steampal -steamdeck -gamepadui -pipewire-dmabuf
  # -O 'DP-3,DP-1,HDMI-A-1,*,eDP-1' -r 75
  # --generate-drm-mode --hdr-enabled --hdr-itm-enable