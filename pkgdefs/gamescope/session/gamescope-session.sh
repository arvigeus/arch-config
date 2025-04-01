#!/bin/sh
set -v

# shellcheck disable=SC3045
ulimit -n 524288

# Limit max temp to ~80°C
asusctl profile -P Balanced
# Alt:
#sudo systemctl stop power-profiles-daemon.service
#sudo ryzenadj --stapm-limit=55000 --fast-limit=55000 --slow-limit=55000

# Enable logging
# exec > /tmp/gamescope-session.log 2>&1

switcherooctl launch gamescope \
  -O '*,eDP-1' -W 2560 -H 1440 -r 75 \
  --adaptive-sync \
  -e --xwayland-count 2 --default-touch-mode 4 --immediate-flips -F fsr --mangoapp \
  -- steam -steamos3 -steampal -steamdeck -gamepadui
  # --generate-drm-mode --hdr-enabled --hdr-itm-enable
  # This broke it:
  # --prefer-vk-device 1002:73ef broke it

gamescope_pid="$!"
kill -9 $gamescope_pid
# shellcheck disable=SC3045
wait -n "$gamescope_pid"