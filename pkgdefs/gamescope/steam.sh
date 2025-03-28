#!/bin/bash

set -e  # Fail on error

# Temporary directory
TEMP_DIR=$(mktemp -d)
REPO_URL="https://github.com/CachyOS/CachyOS-Handheld.git"

# Clone the repo
git clone --depth=1 "$REPO_URL" "$TEMP_DIR"

# Define source files and their destinations
declare -A FILES_TO_COPY=(
    ["usr/bin/steamos-add-to-steam"]="$HOME/.local/bin/"
    ["usr/share/plasma/kickeractions/steam.desktop"]="$HOME/.local/share/plasma/kickeractions/"
    ["usr/share/kservices5/ServiceMenus/steam.desktop"]="$HOME/.local/share/kservices5/ServiceMenus/"
)

# Ensure directories exist and copy files
for SRC in "${!FILES_TO_COPY[@]}"; do
    DEST_DIR="${FILES_TO_COPY[$SRC]}"
    mkdir -p "$DEST_DIR"
    cp "$TEMP_DIR/$SRC" "$DEST_DIR"
done

# Clean up
rm -rf "$TEMP_DIR"