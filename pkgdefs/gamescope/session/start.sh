#!/bin/sh
set -v

# shellcheck disable=SC3045
ulimit -n 524288

sudo systemctl start plugin_loader.service

asusctl profile -P Performance
sudo ryzenadj --tctl-temp=85

# Enable logging
# exec > /tmp/gamescope-session.log 2>&1

switcherooctl launch gamescope \
  --adaptive-sync \
  -e --xwayland-count 2 --default-touch-mode 4 --immediate-flips -F fsr --mangoapp \
  -- steam-native -steamos3 -steampal -steamdeck -gamepadui -pipewire-dmabuf
  # -O 'DP-3,DP-1,HDMI-A-1,*,eDP-1' -r 75
  # --generate-drm-mode --hdr-enabled --hdr-itm-enable

gamescope_pid="$!"
kill -9 $gamescope_pid
# shellcheck disable=SC3045
wait -n "$gamescope_pid"