#!/bin/bash

# shellcheck disable=SC2317

# Define menu entries as arrays: ("Icon" "Label" "Function Name")
MENU_ITEMS=(
    "󱖫|Status|profile_print_status"
    "|Battery: 80% limit|set_battery_80"
    "|Battery: 100% limit|set_battery_100"
    "󰍹|Display: Enable|enable_display"
    "󰶐|Display: Disable|disable_display"
)

PROFILE_ICON="󰊚"
PROFILE_PREFIX="$PROFILE_ICON Profile: "

profile_print_status() {
    notify-send "System Status" "$(zephyrusctl status)"
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

list_profiles() {
    zephyrusctl list | while IFS= read -r profile; do
        [[ -n "$profile" ]] && echo "$PROFILE_PREFIX$profile"
    done
}

apply_profile() {
    local profile=$1

    zephyrusctl apply "$profile"
    profile_print_status
}

# Function to handle selected command
handle_command() {
    if [[ "$1" == "$PROFILE_PREFIX"* ]]; then
        apply_profile "${1#"$PROFILE_PREFIX"}"
        exit 0
    fi

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
list_profiles

exit 0
