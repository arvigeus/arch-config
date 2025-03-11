#!/bin/bash

# Function to handle command execution
handle_command() {
    local cmd="$1"
    case "$cmd" in
    "Profile: Powersave")
        "$HOME/.local/bin/performance_profile" powersave
        supergfxctl --mode Integrated
        profile_print_status
        ;;
    "Profile: Balanced")
        "$HOME/.local/bin/performance_profile" balanced
        supergfxctl --mode Hybrid
        profile_print_status
        ;;
    "Profile: Performance")
        asusctl profile -P Performance
        kscreen-doctor output.eDP-2.mode.0 &>/dev/null
        supergfxctl --mode AsusMuxDgpu
        profile_print_status
        ;;
    "Profile: Status")
        profile_print_status
        ;;
    "Battery: 80% limit")
        asusctl -c 80
        notify-send "Battery" "Charge limit: 80%"
        ;;
    "Battery: 100% limit")
        asusctl -c 100
        notify-send "Battery" "Charge limit: 100%"
        ;;
    "Network: Restart")
        ip link set enp8s0f4u1u4 down
        sleep 7
        ip link set enp8s0f4u1u4 up
        ;;
    "Location: Vietnam")
        notify-send "Location" "Vietnam not implemented"
        ;;
    "Location: Bulgaria")
        notify-send "Location" "Bulgaria not implemented"
        ;;
    "Nextcloud: Sync")
        notify-send "Nextcloud" "Sync not implemented"
        ;;
    "Arr: Start")
        notify-send "Arr" "Start not implemented"
        ;;
    "Arr: Stop")
        notify-send "Arr" "Stop not implemented"
        ;;
    "Podman: Reset")
        podman container rm -a -f
        podman image rm -a -f
        podman volume rm -a -f
        podman network rm "$(podman network ls -q)"
        podman pod rm -a -f
        podman system prune -a -f
        ;;
    "Bash: Reload")
        # shellcheck disable=SC1090
        source ~/.bashrc
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

    notify-send "System Status" "$status"
}

# Check if a command was provided (this happens when user selects an option)
if [ -n "$1" ]; then
    handle_command "$1"
    exit 0
fi

# If no arguments, print the menu items (Rofi will call the script this way first)
cat <<EOF
Profile: Powersave
Profile: Balanced
Profile: Performance
Profile: Status
Battery: 80% limit
Battery: 100% limit
Network: Restart
Location: Vietnam
Location: Bulgaria
Nextcloud: Sync
Arr: Start
Arr: Stop
Podman: Reset
Bash: Reload
EOF

exit 0
