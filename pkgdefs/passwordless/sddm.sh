#!/bin/bash

SDDM_PAM_FILE="/etc/pam.d/sddm"

# Check if the rule exists; if not, modify the file
if ! grep -q "pam_succeed_if.so user ingroup nopasswdlogin" "$SDDM_PAM_FILE"; then
    # Backup the original file
    sudo cp "$SDDM_PAM_FILE" "${SDDM_PAM_FILE}.bak"

    sudo sed -i '/#%PAM-1.0/a \
\
auth        sufficient  pam_succeed_if.so user ingroup nopasswdlogin' "$SDDM_PAM_FILE"

    echo "Passwordless login rule added successfully to /etc/pam.d/sddm."
fi