#!/bin/bash

# shellcheck disable=SC2317

# Define menu entries as arrays: ("Icon" "Label" "Function Name")
MENU_ITEMS=(
    "󱖫|Status|profile_print_status"
    "󰡳|Profile: Powersave|set_profile_powersave"
    "󰊚|Profile: Balanced|set_profile_balanced"
    "󰡴|Profile: Performance|set_profile_performance"
    "|Battery: 80% limit|set_battery_80"
    "|Battery: 100% limit|set_battery_100"
    "󰍹|Display: Enable|enable_display"
    "󰶐|Display: Disable|disable_display"
)

# Function to print CPU and GPU status
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

# Power profiles
set_profile_powersave() {
    "$HOME/.local/bin/performance_profile" powersave
    supergfxctl --mode Integrated
    profile_print_status
}

set_profile_balanced() {
    "$HOME/.local/bin/performance_profile" balanced
    supergfxctl --mode Hybrid
    profile_print_status
}

set_profile_performance() {
    asusctl profile -P Performance
    kscreen-doctor output.eDP-2.mode.0 &>/dev/null
    supergfxctl --mode AsusMuxDgpu
    profile_print_status
}

# Battery limits
set_battery_80() {
    asusctl -c 80
    notify-send -a "Battery" "Charge limit: 80%" --icon="/usr/share/icons/breeze-dark/status/32/battery-080.svg"
}

set_battery_100() {
    asusctl -c 100
    notify-send -a "Battery" "Charge limit: 100%" --icon="/usr/share/icons/breeze-dark/status/32/battery-100.svg"
}

# Display settings
enable_display() {
    notify-send -a "eDP-2" "$(kscreen-doctor output.eDP-2.enable)"
}

disable_display() {
    notify-send -a "eDP-2" "$(kscreen-doctor output.eDP-2.disable)"
}

# Function to handle selected command
handle_command() {
    for item in "${MENU_ITEMS[@]}"; do
        IFS="|" read -r icon label function_name <<<"$item"
        if [[ "$1" == "$icon $label" ]]; then
            "$function_name"
            exit 0
        fi
    done
}

# If a command was provided, execute it
[ -n "$1" ] && handle_command "$1"

# Otherwise, print menu for Rofi
for item in "${MENU_ITEMS[@]}"; do
    IFS="|" read -r icon label _ <<<"$item"
    echo "$icon $label"
done

exit 0
