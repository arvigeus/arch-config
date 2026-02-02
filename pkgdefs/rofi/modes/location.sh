#!/bin/bash

# shellcheck disable=SC2317

# Store absolute path so script can be sourced from any working directory
SCRIPT_PATH="$(realpath "${BASH_SOURCE[0]}")"

# Define menu items ("Label" "Function Name")
MENU_ITEMS=(
    "🇻🇳 Vietnam|set_vietnam"
    "🇧🇬 Bulgaria|set_bulgaria"
)

# Function to set up Vietnam environment
set_vietnam() {
    # Set timezone
    sudo ln -sf /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime
    sudo hwclock --systohc

    # Enable all audio outputs (internal speakers, HDMI display) for manual switching
    # Enable internal speakers/headphones jack
    INTERNAL_CARD=$(pactl list cards short | grep "pci-0000_07_00.6" | awk '{print $2}')
    [ -n "$INTERNAL_CARD" ] && pactl set-card-profile "$INTERNAL_CARD" output:analog-stereo 2>/dev/null

    # Enable and set HDMI display as default (for headphones connected to monitor)
    HDMI_CARD=$(pactl list cards | grep -B20 "available)" | grep -B20 "hdmi-output" | grep "Name:" | head -1 | awk '{print $2}')
    if [ -n "$HDMI_CARD" ]; then
        pactl set-card-profile "$HDMI_CARD" output:hdmi-stereo 2>/dev/null
        HDMI_SINK=$(pactl list sinks short | grep hdmi-stereo | grep -v "SUSPENDED" | head -1 | awk '{print $2}')
        [ -n "$HDMI_SINK" ] && pactl set-default-sink "$HDMI_SINK"
    fi

    # grep -qxF '185.199.108.154 github.githubassets.com' /etc/hosts || echo '185.199.108.154 github.githubassets.com' | sudo tee -a /etc/hosts > /dev/null

    # Update KDE weather widget to show Vietnam location
    for config in "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc" "$HOME/.config/plasmashellrc"; do
        sed -i '/^source=/c\source=wettercom|weather|Ha Long, Tinh Quang Ninh, VN|VN1580410;Ha Long' "$config"
        sed -i '/^placeDisplayName=/c\placeDisplayName=Ha Long, Tinh Quang Ninh, VN' "$config"
        sed -i '/^placeInfo=/c\placeInfo=place|Ha Long, Tinh Quang Ninh, VN|extra|VN1580410;Ha Long' "$config"
    done

    # Restart plasmashell to apply weather widget changes
    (sleep 1 && kquitapp6 plasmashell && sleep 2 && plasmashell --replace &) >/dev/null 2>&1

    # Update pacman mirror list
    sudo systemctl start reflector.service

    notify-send -a "Location" "Xin chào Việt Nam!" --icon="$HOME/.icons/flags/flag-vn.png"
}

# Function to set up Bulgaria environment
set_bulgaria() {
    # Set timezone
    sudo ln -sf /usr/share/zoneinfo/Europe/Sofia /etc/localtime
    sudo hwclock --systohc

    # sudo sed -i '/185\.199\.108\.154 github\.githubassets\.com/d' /etc/hosts

    # Update KDE weather widget to show Bulgaria location
    for config in "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc" "$HOME/.config/plasmashellrc"; do
        sed -i '/^source=/c\source=wettercom|weather|Yantra, Oblast Veliko Tarnovo, BG|BG0725564;Yantra' "$config"
        sed -i '/^placeDisplayName=/c\placeDisplayName=Yantra, Oblast Veliko Tarnovo, BG' "$config"
        sed -i '/^placeInfo=/c\placeInfo=place|Yantra, Oblast Veliko Tarnovo, BG|extra|BG0725564;Yantra' "$config"
    done

    # Restart plasmashell to apply weather widget changes
    (sleep 1 && kquitapp6 plasmashell && sleep 2 && plasmashell --replace &) >/dev/null 2>&1

    # Update pacman mirror list
    sudo systemctl start reflector.service

    notify-send -a "Location" "Добре дошъл у дома!" --icon="$HOME/.icons/flags/flag-bg.png"
}

# Function to handle command execution
handle_command() {
    for item in "${MENU_ITEMS[@]}"; do
        IFS="|" read -r label function_name <<<"$item"
        if [[ "$1" == "$label" ]]; then
            # Fire and forget: run function in background so rofi doesn't hang
            bash -c "source '$SCRIPT_PATH'; $function_name" >/dev/null 2>&1 &
            disown
            exit 0
        fi
    done
}

# Only run menu/command logic when executed directly (not when sourced for function definitions)
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    # If a command was provided, execute it
    [ -n "$1" ] && handle_command "$1"

    # Otherwise, print menu for Rofi
    for item in "${MENU_ITEMS[@]}"; do
        IFS="|" read -r label _ <<<"$item"
        echo "$label"
    done

    exit 0
fi
