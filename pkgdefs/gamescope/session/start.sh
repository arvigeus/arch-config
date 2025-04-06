#!/bin/sh
set -v

# shellcheck disable=SC3045
ulimit -n 524288

# asusctl profile -P Performance

# Max TDP is supposedly 100, but 40-50 have measurable effect
[ -n "$TDP_LIMIT" ] && sudo ryzenadj --stapm-limit="${TDP_LIMIT}000" --fast-limit="${TDP_LIMIT}000" --slow-limit="${TDP_LIMIT}000"

sudo systemctl start plugin_loader.service

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