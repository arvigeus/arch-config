#!/bin/sh
set -v
set -e  # Exit on error

# Enable logging
exec > ~/gamescope.log 2>&1

# shellcheck disable=SC3045
ulimit -n 524288 || echo "Failed to set ulimit"

sudo systemctl start plugin_loader.service || echo "Failed to start plugin_loader.service"

asusctl profile -P Performance || echo "Failed to set ASUS performance profile"

sudo ryzenadj --tctl-temp=80 || echo "Failed to adjust Ryzen temperature control"

switcherooctl launch gamescope \
  --adaptive-sync \
  -e --xwayland-count 2 --default-touch-mode 4 --immediate-flips -F fsr --mangoapp \
  -- steam-native -steamos3 -steampal -steamdeck -gamepadui -pipewire-dmabuf
  # -O 'DP-3,DP-1,HDMI-A-1,*,eDP-1' -r 75
  # --generate-drm-mode --hdr-enabled --hdr-itm-enable