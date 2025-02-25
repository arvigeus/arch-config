#!/bin/bash

if ! grep -qxF 'ELECTRON_OZONE_PLATFORM_HINT=wayland' "$HOME/.env"; then
    echo 'ELECTRON_OZONE_PLATFORM_HINT=wayland' >> "$HOME/.env"
fi
