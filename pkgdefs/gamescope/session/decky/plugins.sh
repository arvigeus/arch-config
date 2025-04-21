#!/bin/bash

install_decky_plugin() {
  local REPO=$1
  local PLUGIN_NAME=$2
  local PLUGIN_DIR="$HOME/homebrew/plugins"

  # Only run installation if plugin doesn't exist
  if [ -d "$PLUGIN_DIR/$PLUGIN_NAME" ]; then
    return 0
  fi

  RELEASE_INFO=$(curl -s "https://api.github.com/repos/$REPO/releases/latest") || { echo "Error: Failed to fetch release info for $REPO"; return 1; }
  DOWNLOAD_URL=$(echo "$RELEASE_INFO" | grep -o '"browser_download_url": "[^"]*\.zip"' | cut -d'"' -f4 | head -n 1) || { echo "Error: No download URL found for $REPO"; return 1; }

  # Create plugin directory if it doesn't exist
  if [ ! -d "$PLUGIN_DIR" ]; then
    mkdir -p "$PLUGIN_DIR" || { echo "Error: Failed to create plugin directory"; return 1; }
  fi

  TEMP_ZIP="/tmp/$PLUGIN_NAME/temp_plugin.zip"
  mkdir -p "/tmp/$PLUGIN_NAME"
  curl -sL -o "$TEMP_ZIP" "$DOWNLOAD_URL" || { echo "Error: Download failed for $PLUGIN_NAME"; return 1; }
  sudo unzip -qo "$TEMP_ZIP" -d "$PLUGIN_DIR" || { echo "Error: Extraction failed for $PLUGIN_NAME"; return 1; }
  rm -f "$TEMP_ZIP"

  if [ ! -d "$PLUGIN_DIR/$PLUGIN_NAME" ]; then
    EXTRACTED_FOLDER=$(find "$PLUGIN_DIR" -maxdepth 1 -type d -name "*protondb*" | head -n 1)
    if [ -n "$EXTRACTED_FOLDER" ]; then
      sudo mv "$EXTRACTED_FOLDER" "$PLUGIN_DIR/$PLUGIN_NAME" || { echo "Error: Failed to rename extracted folder"; return 1; }
    fi
  fi

  [ ! -d "$PLUGIN_DIR/$PLUGIN_NAME" ] && echo "Error: Installation failed: Plugin folder $PLUGIN_NAME not found" && return 1

  return 0
}

# Example usage
install_decky_plugin "OMGDuke/protondb-decky" "protondb-decky"
install_decky_plugin "hulkrelax/hltb-for-deck" "hltb-for-deck"
