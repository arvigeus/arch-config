#!/bin/bash

list_services() {
    systemctl list-units --type=service --no-pager --no-legend | awk '{print $1}'
}

list_actions() {
    echo -e "status\nrestart\nstop\nenable\ndisable\nlogs"
}

handle_selection() {
    selection="$1"
    if [[ -z "$selection" ]]; then
        exit 0
    fi

    # Check if it's a service or an action
    if [[ "$selection" == *".service" ]]; then
        list_actions | awk -v svc="$selection" '{print svc " " $0}'
    else
        service=$(echo "$selection" | awk '{print $1}')
        action=$(echo "$selection" | awk '{print $2}')

        case "$action" in
        logs) sudo journalctl -u "$service" --no-pager | less ;;
        *) sudo systemctl "$action" "$service" ;;
        esac
    fi
}

if [[ -z "$1" ]]; then
    list_services
else
    handle_selection "$1"
fi
