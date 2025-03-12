#!/bin/bash

# Function to handle command execution
handle_command() {
    local cmd="$1"
    case "$cmd" in
    "󱖫 Status")
        profile_print_status
        ;;
    "󰡳 Profile: Powersave")
        "$HOME/.local/bin/performance_profile" powersave
        supergfxctl --mode Integrated
        profile_print_status
        ;;
    "󰊚 Profile: Balanced")
        "$HOME/.local/bin/performance_profile" balanced
        supergfxctl --mode Hybrid
        profile_print_status
        ;;
    "󰡴 Profile: Performance")
        asusctl profile -P Performance
        kscreen-doctor output.eDP-2.mode.0 &>/dev/null
        supergfxctl --mode AsusMuxDgpu
        profile_print_status
        ;;
    " Battery: 80% limit")
        asusctl -c 80
        notify-send -a "Battery" "Charge limit: 80%" --icon="/usr/share/icons/breeze-dark/status/32/battery-080.svg"
        ;;
    " Battery: 100% limit")
        asusctl -c 100
        notify-send -a "Battery" "Charge limit: 100%" --icon="/usr/share/icons/breeze-dark/status/32/battery-100.svg"
        ;;
    "󰍹 Display: Enable")
        notify-send -a "eDP-2" "$(kscreen-doctor output.eDP-2.enable)"
        ;;
    "󰶐 Display: Disable")
        notify-send -a "eDP-2" "$(kscreen-doctor output.eDP-2.disable)"
        ;;
    esac
}

# Function to get CPU mode
profile_print_status() {
    local cpu_mode gpu_mode resolution output starred_part status

    cpu_mode=$(asusctl profile -p | awk '{print $NF}')

    gpu_mode=$(supergfxctl -g)
    [[ "$gpu_mode" == "AsusMuxDgpu" ]] && gpu_mode="Dedicated"

    output=$(kscreen-doctor -o | grep "eDP-2")
    starred_part=$(echo "$output" | grep -o "[0-9x@]*\*")
    resolution=${starred_part%\*}

    status=$(printf "CPU mode: <b>%s</b>\nGraphics mode: <b>%s</b>\nDisplay: <b>%s</b>" \
        "$cpu_mode" "$gpu_mode" "$resolution")

    notify-send -a "System Status" "$status"
}

# Check if a command was provided (this happens when user selects an option)
if [ -n "$1" ]; then
    handle_command "$1"
    exit 0
fi

# If no arguments, print the menu items (Rofi will call the script this way first)
cat <<EOF
󱖫 Status
󰡳 Profile: Powersave
󰊚 Profile: Balanced
󰡴 Profile: Performance
 Battery: 80% limit
 Battery: 100% limit
󰍹 Display: Enable
󰶐 Display: Disable
EOF

exit 0
