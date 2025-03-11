#!/bin/bash

# Function to handle command execution
handle_command() {
    local cmd="$1"
    case "$cmd" in
    "Network: Restart")
        ip link set enp8s0f4u1u4 down
        sleep 7
        ip link set enp8s0f4u1u4 up
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

# Check if a command was provided (this happens when user selects an option)
if [ -n "$1" ]; then
    handle_command "$1"
    exit 0
fi

# If no arguments, print the menu items (Rofi will call the script this way first)
cat <<EOF
Network: Restart
Nextcloud: Sync
Arr: Start
Arr: Stop
Podman: Reset
Bash: Reload
EOF

exit 0
