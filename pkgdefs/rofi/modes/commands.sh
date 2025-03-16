#!/bin/bash

# shellcheck disable=SC2317

# Define menu items ("Label" "Function Name")
MENU_ITEMS=(
    "WARP: Connect|warp_connect"
    "WARP: Disconnect|warp_disconnect"
    "WARP: Status|warp_status"
    "Network: Restart|network_restart"
    "Nextcloud: Sync|nextcloud_sync"
    "Arr: Start|arr_start"
    "Arr: Stop|arr_stop"
    "Podman: Reset|podman_reset"
    "Bash: Reload|bash_reload"
)

# WARP functions
warp_connect() {
    notify-send -a "WARP" "Connect: $(warp-cli connect)" --icon="/usr/share/icons/hicolor/scalable/apps/zero-trust-connected.svg"
}

warp_disconnect() {
    notify-send -a "WARP" "Disconnect: $(warp-cli disconnect)" --icon="/usr/share/icons/hicolor/scalable/apps/zero-trust-disconnected.svg"
}

warp_status() {
    notify-send -a "WARP" "$(warp-cli status)" --icon="/usr/share/icons/hicolor/scalable/apps/zero-trust-orange.svg"
}

# Network functions
network_restart() {
    ip link set enp8s0f4u1u4 down
    sleep 7
    ip link set enp8s0f4u1u4 up
}

# Nextcloud functions
nextcloud_sync() {
    notify-send -a "Nextcloud" "Sync not implemented"
}

# Arr functions
arr_start() {
    notify-send -a "Arr" "Start not implemented"
}

arr_stop() {
    notify-send -a "Arr" "Stop not implemented"
}

# Podman functions
podman_reset() {
    podman container rm -a -f
    podman image rm -a -f
    podman volume rm -a -f
    podman network rm "$(podman network ls -q)"
    podman pod rm -a -f
    podman system prune -a -f
}

# Bash functions
bash_reload() {
    # shellcheck disable=SC1090
    source ~/.bashrc
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
