#!/bin/bash

[ -f "$HOME/homebrew/services/.loader.version" ] || curl -fsSL https://github.com/SteamDeckHomebrew/decky-installer/releases/latest/download/install_release.sh | sh

source ./pkgdefs/gamescope/session/decky/plugins.sh