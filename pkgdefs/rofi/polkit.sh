#!/bin/bash

NETWORK_RULE_FILE="/etc/polkit-1/rules.d/50-network.rules"

if ! sudo test -f "$NETWORK_RULE_FILE"; then
    echo "Creating networking polkit rule for group 'wheel'..."

    sudo tee "$NETWORK_RULE_FILE" > /dev/null <<EOF
polkit.addRule(function(action, subject) {
    if (action.id == "org.freedesktop.network1.link.modify" &&
        subject.isInGroup("wheel")) {
        return polkit.Result.YES;
    }
});
EOF

    sudo systemctl restart polkit
fi
