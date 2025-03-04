#!/bin/bash

# Ensure the group exists
if ! getent group nopasswdlogin >/dev/null; then
    sudo groupadd -r nopasswdlogin
    echo "Created group: nopasswdlogin"
fi

# Add user to nopasswdlogin group if not already a member
if ! id -nG "$USER" | grep -qw "nopasswdlogin"; then
    sudo usermod -aG nopasswdlogin "$USER"
    echo "Added $USER to nopasswdlogin group."
fi
