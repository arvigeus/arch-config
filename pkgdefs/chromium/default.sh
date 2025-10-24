#!/bin/bash

source ./utils/file.sh

sudo pacman -S --needed --noconfirm chromium

flatpak install -y flathub com.google.Chrome

source ./pkgdefs/browser-extensions/default.sh
install_browser_extensions "chromium"

# TODO: Policies: https://github.com/arvigeus/nixos-config/blob/master/apps/chromium.nix

# Allow Google Sync for Chromium
# These keys are from public web
mkdir -p "$HOME/.config/environment.d"
cp -u -p ./pkgdefs/chromium/env.conf "$HOME/.config/environment.d/chromium.conf"
systemctl --user daemon-reexec
