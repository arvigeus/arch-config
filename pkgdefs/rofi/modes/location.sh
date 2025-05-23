#!/bin/bash

# shellcheck disable=SC2317

# Define menu items ("Label" "Function Name")
MENU_ITEMS=(
    "🇻🇳 Vietnam|set_vietnam"
    "🇧🇬 Bulgaria|set_bulgaria"
)

# Function to set up Vietnam environment
set_vietnam() {
    mapfile -t args < <(grep -vE '^\s*#|^\s*$' /etc/xdg/reflector/reflector.conf | xargs -n1) && sudo reflector "${args[@]}"


    sudo ln -sf /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime
    sudo hwclock --systohc

    pactl set-default-sink alsa_output.pci-0000_07_00.1.hdmi-stereo

    grep -qxF '185.199.108.154 github.githubassets.com' /etc/hosts || echo '185.199.108.154 github.githubassets.com' | sudo tee -a /etc/hosts > /dev/null

    sed -i '/^source=wettercom|weather|/c\source=wettercom|weather|Ha Long, Tinh Quang Ninh, VN|VN1580410;Ha Long' \
        "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc" "$HOME/.config/plasmashellrc"
    
    (sleep 1 && kquitapp6 plasmashell && sleep 2 && plasmashell --replace &) >/dev/null 2>&1

    notify-send -a "Location" "Xin chào Việt Nam!" --icon="$HOME/.icons/flags/flag-vn.png"
}

# Function to set up Bulgaria environment
set_bulgaria() {
    mapfile -t args < <(grep -vE '^\s*#|^\s*$' /etc/xdg/reflector/reflector.conf | xargs -n1) && sudo reflector "${args[@]}"


    sudo ln -sf /usr/share/zoneinfo/Europe/Sofia /etc/localtime
    sudo hwclock --systohc

    sudo sed -i '/185\.199\.108\.154 github\.githubassets\.com/d' /etc/hosts

    sed -i '/^source=wettercom|weather|/c\source=wettercom|weather|Yantra, Oblast Gabrovo, BG|BG0725565;Yantra' \
        "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc" "$HOME/.config/plasmashellrc"

    (sleep 1 && kquitapp6 plasmashell && sleep 2 && plasmashell --replace &) >/dev/null 2>&1

    notify-send -a "Location" "Добре дошъл у дома!" --icon="$HOME/.icons/flags/flag-bg.png"
}

# Function to handle command execution
handle_command() {
    for item in "${MENU_ITEMS[@]}"; do
        IFS="|" read -r label function_name <<<"$item"
        if [[ "$1" == "$label" ]]; then
            "$function_name"
            exit 0
        fi
    done
}

# If a command was provided, execute it
[ -n "$1" ] && handle_command "$1"

# Otherwise, print menu for Rofi
for item in "${MENU_ITEMS[@]}"; do
    IFS="|" read -r label _ <<<"$item"
    echo "$label"
done

exit 0
