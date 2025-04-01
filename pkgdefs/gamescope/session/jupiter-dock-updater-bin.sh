#!/bin/bash

set -eu

if [[ $EUID -ne 0 ]];
then
    exec pkexec --disable-internal-agent "$0" "$@"
fi

exec /usr/lib/jupiter-dock-updater/jupiter-dock-updater.sh "$@"
