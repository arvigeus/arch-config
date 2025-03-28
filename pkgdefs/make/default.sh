#!/bin/bash

echo "MAKEFLAGS=\"--jobs=$(nproc)\"" | sudo tee /etc/makepkg.conf.d/makeflags.conf

