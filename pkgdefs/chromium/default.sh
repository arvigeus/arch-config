#!/bin/bash

source ./utils/file.sh

sudo pacman -S --needed --noconfirm chromium

source ./pkgdefs/browser-extensions/default.sh
install_browser_extensions "chromium"

# TODO: Policies: https://github.com/arvigeus/nixos-config/blob/master/apps/chromium.nix

# Allow Google Sync for Chromium
# These keys are from public web
file_add_line "GOOGLE_DEFAULT_CLIENT_ID=77185425430.apps.googleusercontent.com" "$HOME/.env"
file_add_line "GOOGLE_DEFAULT_CLIENT_SECRET=OTJgUOQcT7lO7GsGZq2G4IlT" "$HOME/.env"
