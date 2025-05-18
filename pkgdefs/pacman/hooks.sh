#!/bin/bash

sudo mkdir -p /etc/pacman.d/hooks

sudo cp -u -p ./pkgdefs/pacman/hooks/* /etc/pacman.d/hooks