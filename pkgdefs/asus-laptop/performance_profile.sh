#!/bin/bash

profile_powersave() {
    asusctl profile -P Quiet
    kscreen-doctor output.eDP-2.mode.21 &> /dev/null
    powertop --auto-tune &> /dev/null
}

profile_balanced() {
    asusctl profile -P Balanced
    kscreen-doctor output.eDP-2.mode.0 &> /dev/null
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