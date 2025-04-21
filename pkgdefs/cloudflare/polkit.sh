#!/bin/bash

WARP_RULE_FILE="/etc/polkit-1/rules.d/90-warp-service.rules"

if ! sudo test -f "$WARP_RULE_FILE"; then
    echo "Creating WARP service polkit rule for group 'wheel'..."

    sudo tee "$WARP_RULE_FILE" > /dev/null <<EOF
polkit.addRule(function(action, subject) {
    if ((action.id == "org.freedesktop.systemd1.manage-units" ||
         action.id == "org.freedesktop.systemd1.manage-unit-files") &&
        action.lookup("unit") == "warp-svc.service" &&
        subject.isInGroup("wheel")) {
            return polkit.Result.YES;
    }
});
EOF

    sudo systemctl restart polkit
fi
