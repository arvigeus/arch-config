#!/bin/bash

profile_powersave() {
    "$HOME/.local/bin/performance_profile powersave"
    supergfxctl --mode Integrated
    profile_print_status
}

profile_balanced() {
    "$HOME/.local/bin/performance_profile balanced"
    supergfxctl --mode Hybrid
    profile_print_status
}

profile_performance() {
    asusctl profile -P Performance
    kscreen-doctor output.eDP-2.mode.0 &> /dev/null
    supergfxctl --mode AsusMuxDgpu
    profile_print_status
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

    notify-send --app-name "Asus Zephyrus G14" "Status" "$status"
}

battery_charge_limit() {
    local charge_limit=$1
    asusctl -c "$charge_limit"
    notify-send --app-name "Asus Zephyrus G14" "Battery" "Charge limit: $charge_limit"
}

network_restart() {
    ip link set enp8s0f4u1u4 down
    sleep 7
    ip link set enp8s0f4u1u4 up
}

location_vietnam() {
    notify-send --app-name "location_vietnam" "TODO" "Not implemented"
}

location_bulgaria() {
    notify-send --app-name "location_bulgaria" "TODO" "Not implemented"
}

nextcloud_sync() {
    notify-send --app-name "nextcloud_sync" "TODO" "Not implemented"
}

bluetooth_start() {
    pkexec systemctl start bluetooth
}

bluetooth_stop() {
    pkexec systemctl start bluetooth
}

arr_start() {
    notify-send --app-name "arr_start" "TODO" "Not implemented"
}

arr_stop() {
    notify-send --app-name "arr_stop" "TODO" "Not implemented"
}

podman_reset() {
    podman container rm -a -f
    podman image rm -a -f
    podman volume rm -a -f
    podman network rm "$(podman network ls -q)"
    podman pod rm -a -f
    podman system prune -a -f
}

bash_reload() {
    # shellcheck disable=SC1090
    source ~/.bashrc
}

# Define the options and their corresponding functions
OPTIONS=(
    "Profile: Powersave|profile_powersave"
    "Profile: Balanced|profile_balanced"
    "Profile: Performance|profile_performance"
    "Profile: Status|profile_print_status"
    "Battery: Enable charge limit|battery_charge_limit 80"
    "Battery: Disable charge limit|battery_charge_limit 100"
    "Network: Restart|network_restart"
    "Location: Vietnam|location_vietnam"
    "Location: Bulgaria|location_bulgaria"
    "Nextcloud: Sync|nextcloud_sync"
    "Bluetooth: Start|bluetooth_start"
    "Bluetooth: Stop|bluetooth_stop"
    "Arr: Start|arr_start"
    "Arr: Stop|arr_stop"
    "Podman: Reset|podman_reset"
    "Bash: Reload|bash_reload"
)

# Use rofi to display options and get the selected choice
CHOICE=$(printf "%s\n" "${OPTIONS[@]}" | awk -F'|' '{print $1}' | rofi -dmenu -i -p "Select action:")

# If a choice was made, execute the corresponding function
if [ -n "$CHOICE" ]; then
    # Find the selected function based on the choice
    FUNCTION=$(printf "%s\n" "${OPTIONS[@]}" | grep -i "^$CHOICE|" | awk -F'|' '{print $2}')
    
    if [ -n "$FUNCTION" ]; then
        # Call the function directly
        eval "$FUNCTION"
    fi
fi
