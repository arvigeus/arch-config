#!/bin/bash

[ -f "$HOME/homebrew/services/.loader.version" ] || curl -fsSL https://github.com/SteamDeckHomebrew/decky-installer/releases/latest/download/install_release.sh | sh

sudo setcap 'CAP_SYS_NICE=eip' "$(which gamescope)"

sudo cp -u -p ./pkgdefs/gamescope/session/start.sh /usr/bin/gamescope-session
sudo chmod +x /usr/bin/gamescope-session

sudo cp -u -p ./pkgdefs/gamescope/session/stop.sh /usr/bin/steamos-session-select
sudo chmod +x /usr/bin/steamos-session-select

# Session
sudo cp -u -p ./pkgdefs/gamescope/session/gamescope.desktop /usr/share/wayland-sessions/gamescope.desktop

FILES="./pkgdefs/gamescope/session/files"
# Make all files in '$FILES' executable
find "$FILES" -type f -exec chmod +x {} \;
# Move contents of '$FILES' to '/'
sudo rsync -a --no-o --no-g --chown=root:root "$FILES"/ /
# Misc
sudo mkdir -p /etc/gamescope/scripts
mkdir -p "$HOME/.config/gamescope/scripts"
