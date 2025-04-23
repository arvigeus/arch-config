#!/bin/bash

sudo pacman -S --needed --noconfirm firefox

source ./pkgdefs/browser-extensions/default.sh
install_browser_extensions "firefox"

# Needed for Mozilla specific files
sudo pacman -S --needed --noconfirm python-lz4
# NOTE: lz4 doesn't work here

sleep 5 # Need to wait to open browser tabs
grep '^Path=' "$HOME/.mozilla/firefox/profiles.ini" | sed 's/^Path=//' | while read -r profile; do
  cp -u -p ./pkgdefs/firefox/user.js "$HOME/.mozilla/firefox/$profile/user.js"
  python ./pkgdefs/firefox/lz4-compress.py ./pkgdefs/firefox/search.json > "$HOME/.mozilla/firefox/$profile/search.json.mozlz4"
done