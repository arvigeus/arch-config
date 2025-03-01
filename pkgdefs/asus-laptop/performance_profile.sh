#!/bin/bash

profile_powersave() {
    asusctl profile -P Quiet  &> /dev/null
    if kscreen-doctor -o | grep -A3 "eDP-2" | grep -q "enabled"; then
        kscreen-doctor output.eDP-2.mode.2560x1600@60  &> /dev/null
    fi
    powertop --auto-tune &> /dev/null
}

profile_balanced() {
    asusctl profile -P Balanced  &> /dev/null
    if kscreen-doctor -o | grep -A3 "eDP-2" | grep -q "enabled"; then
        kscreen-doctor output.eDP-2.mode.2560x1600@120 &> /dev/null
    fi
}

# Main function to handle arguments
case "$1" in
    powersave) profile_powersave ;;
    balanced) profile_balanced ;;
    *)
        echo "Usage: $0 {powersave|balanced}"
        exit 1
        ;;
esac