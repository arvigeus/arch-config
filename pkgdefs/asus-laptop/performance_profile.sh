#!/bin/bash

profile_powersave() {
    asusctl profile -P Quiet  &> /dev/null
    amd-boost 0
    sudo ryzenadj --power-saving  &> /dev/null
    powertop --auto-tune &> /dev/null

    if kscreen-doctor -o | grep -A3 "eDP-2" | grep -q "enabled"; then
        kscreen-doctor output.eDP-2.mode.2560x1600@60  &> /dev/null
    fi

    mkdir -p ~/.config/environment.d
    echo "MESA_VK_DEVICE_SELECT=1002:1681!" > ~/.config/environment.d/powersave.conf
    systemctl --user daemon-reexec

}

profile_balanced() {
    asusctl profile -P Balanced  &> /dev/null
    amd-boost 1
    
    if kscreen-doctor -o | grep -A3 "eDP-2" | grep -q "enabled"; then
        kscreen-doctor output.eDP-2.mode.2560x1600@120 &> /dev/null
    fi

    if [ -f ~/.config/environment.d/powersave.conf ]; then
        rm ~/.config/environment.d/powersave.conf
        systemctl --user daemon-reexec
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