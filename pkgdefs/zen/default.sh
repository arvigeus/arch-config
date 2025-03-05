#!/bin/bash

sudo pacman -S --needed --noconfirm zen-browser-bin

source ./pkgdefs/browser-extensions/default.sh
install_browser_extensions "firefox" "zen-browser"
