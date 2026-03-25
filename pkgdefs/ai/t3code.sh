#!/bin/bash

REPO="pingdotgg/t3code"
APPIMAGE_PATTERN="x86_64.AppImage"
# Get latest release download URL
DOWNLOAD_URL=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" \
  | grep -o '"browser_download_url": "[^"]*'"$APPIMAGE_PATTERN"'"' \
  | cut -d'"' -f4 | head -n 1)

if [ -z "$DOWNLOAD_URL" ]; then
  echo "Failed to find AppImage download URL"
  exit 1
fi

FILENAME=$(basename "$DOWNLOAD_URL")
TEMP_FILE="/tmp/$FILENAME"

curl -L -o "$TEMP_FILE" "$DOWNLOAD_URL"
chmod +x "$TEMP_FILE"

flatpak run it.mijorus.gearlever --integrate --yes "$TEMP_FILE"

# Find the integrated AppImage path
APPIMAGE_PATH=$(flatpak run it.mijorus.gearlever --list-installed \
  | grep -i "t3.code" | grep -oP '/\S+\.appimage$')

if [ -n "$APPIMAGE_PATH" ]; then
  flatpak run it.mijorus.gearlever --set-update-source "$APPIMAGE_PATH" --manager github repo="$REPO"
fi

rm -f "$TEMP_FILE"
