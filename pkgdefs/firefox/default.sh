#!/bin/bash

sudo pacman -S --needed --noconfirm firefox

source ./pkgdefs/browser-extensions/default.sh
install_browser_extensions "firefox"

# TODO: Settings: https://github.com/arvigeus/nixos-config/blob/master/apps/firefox.nix

# TODO: Enable plasma integration
# about:config: widget.use-xdg-desktop-portal.file-picker 1