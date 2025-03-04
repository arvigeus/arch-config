#!/bin/bash

KDE_PAM_FILE="/etc/pam.d/kde"

# Check if the rule exists; if not, modify the file
if ! grep -q "pam_succeed_if.so user ingroup nopasswdlogin" "$KDE_PAM_FILE"; then
    # Backup the original file
    sudo cp "$KDE_PAM_FILE" "${KDE_PAM_FILE}.bak"

    sudo sed -i '/#%PAM-1.0/a \
\
auth        sufficient  pam_succeed_if.so user ingroup nopasswdlogin' "$KDE_PAM_FILE"

    echo "Passwordless login rule added successfully to /etc/pam.d/kde."
fi