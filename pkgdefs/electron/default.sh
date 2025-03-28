#!/bin/bash

mkdir -p "$HOME/.config/environment.d"
cp -u -p ./pkgdefs/electron/env.conf "$HOME/.config/environment.d/electron.conf"
systemctl --user daemon-reexec
