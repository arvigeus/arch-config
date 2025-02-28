#!/bin/bash

NETWORK_RULE_FILE="/etc/polkit-1/rules.d/50-network.rules"

if [ ! -f "$NETWORK_RULE_FILE" ]; then
    echo "Creating polkit rule for $USER..."
    
    echo "polkit.addRule(function(action, subject) {
        if (action.id == \"org.freedesktop.network1.link.modify\" &&
            subject.user == \"$USER\") {
            return polkit.Result.YES;
        }
    });" | sudo tee "$NETWORK_RULE_FILE" > /dev/null

    sudo systemctl restart polkit
fi
