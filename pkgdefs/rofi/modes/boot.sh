#!/bin/bash

list_boot_info() {
    echo -e "Service Load Times\nCritical Chain (boot order)"
}

handle_selection() {
    case "$1" in
        "Service Load Times")
            systemd-analyze blame
            ;;
        "Critical Chain (boot order)")
            systemd-analyze critical-chain
            ;;
        *)
            exit 0
            ;;
    esac
}

if [[ -z "$1" ]]; then
    list_boot_info
else
    handle_selection "$1"
fi
