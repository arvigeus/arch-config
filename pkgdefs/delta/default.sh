#!/bin/bash

sudo pacman -S --needed --noconfirm git-delta diffutils

mkdir -p "$HOME/.config/environment.d"
cp -u -p ./pkgdefs/delta/env.conf "$HOME/.config/environment.d/delta.conf"
systemctl --user daemon-reexec
