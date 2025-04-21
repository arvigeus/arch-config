#!/bin/bash

sudo pacman -S --needed --noconfirm firefox

# TODO: Search engines: Kagi, DDG, Ecosia

source ./pkgdefs/browser-extensions/default.sh
install_browser_extensions "firefox"

sleep 5 # Need to wait to open browser tabs
grep '^Path=' "$HOME/.mozilla/firefox/profiles.ini" | sed 's/^Path=//' | while read -r profile; do
  cp -u -p ./pkgdefs/firefox/user.js "$HOME/.mozilla/firefox/$profile/user.js"
done