#!/bin/bash

# Function to handle command execution
handle_command() {
    local cmd="$1"
    case "$cmd" in
    "🇻🇳 Vietnam")
        sudo reflector --country Vietnam --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

        sudo ln -sf /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime
        sudo hwclock --systohc

        sed -i '/^source=wettercom|weather|/c\source=wettercom|weather|Ha Long, Tinh Quang Ninh, VN|VN1580410;Ha Long' "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc" "$HOME/.config/plasmashellrc"
        (sleep 1 && kquitapp6 plasmashell && sleep 2 && plasmashell --replace &) >/dev/null 2>&1

        sudo systemctl enable warp-svc.service --now
        sleep 1
        warp-cli connect

        notify-send -a "Location" "Xin chào Việt Nam!" --icon="$HOME/.icons/flags/flag-vn.png"
        ;;
    "🇧🇬 Bulgaria")
        sudo reflector --country Bulgaria --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

        sudo ln -sf /usr/share/zoneinfo/Europe/Sofia /etc/localtime
        sudo hwclock --systohc

        sed -i '/^source=wettercom|weather|/c\source=wettercom|weather|Yantra, Oblast Gabrovo, BG|BG0725565;Yantra' "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc" "$HOME/.config/plasmashellrc"
        (sleep 1 && kquitapp6 plasmashell && sleep 2 && plasmashell --replace &) >/dev/null 2>&1

        warp-cli disconnect
        sudo systemctl disable warp-svc.service

        notify-send -a "Location" "Добре дошъл у дома!" --icon="$HOME/.icons/flags/flag-bg.png"
        ;;
    esac
}

# Check if a command was provided (this happens when user selects an option)
if [ -n "$1" ]; then
    handle_command "$1"
    exit 0
fi

# If no arguments, print the menu items (Rofi will call the script this way first)
cat <<EOF
🇻🇳 Vietnam
🇧🇬 Bulgaria
EOF

exit 0
