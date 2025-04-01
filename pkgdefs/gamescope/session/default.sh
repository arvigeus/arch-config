#!/bin/bash

# Startup
sudo cp -u -p ./pkgdefs/gamescope/session/gamescope-session.sh /usr/bin/gamescope-session
sudo chmod +x /usr/bin/gamescope-session

# Shut down
sudo cp -u -p ./pkgdefs/gamescope/session/steamos-session-select.sh /usr/bin/steamos-session-select
sudo chmod +x /usr/bin/steamos-session-select

# Session
sudo cp -u -p ./pkgdefs/gamescope/session/gamescope.desktop /usr/share/wayland-sessions/gamescope.desktop

# Misc
## If these don't work, try installing `gamescope-session-steam-git`, login, then delete it
sudo cp -u -p ./pkgdefs/gamescope/session/steamos-select-branch.sh /usr/bin/steamos-select-branch
sudo chmod +x /usr/bin/steamos-select-branch
sudo mkdir -p /usr/bin/steamos-polkit-helpers
sudo cp -u -p ./pkgdefs/gamescope/session/jupiter-dock-updater-bin.sh /usr/bin/steamos-polkit-helpers/jupiter-dock-updater
sudo chmod +x /usr/bin/steamos-polkit-helpers/jupiter-dock-updater
sudo mkdir -p /usr/lib/jupiter-dock-updater
sudo cp -u -p ./pkgdefs/gamescope/session/jupiter-dock-updater-lib.sh /usr/lib/jupiter-dock-updater/jupiter-dock-updater.sh
sudo chmod +x /usr/lib/jupiter-dock-updater/jupiter-dock-updater.sh

sudo setcap 'CAP_SYS_NICE=eip' "$(which gamescope)"
