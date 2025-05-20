#!/bin/bash

PLUGIN_DIR="$HOME/homebrew/plugins"
PLUGIN_STORE_URL="https://plugins.deckbrew.xyz/plugins"
STORE_CACHE="/tmp/decky_store_cache.json"

# Fetch store data once and cache it
fetch_store_data() {
  if [ ! -f "$STORE_CACHE" ] || [ "$(find "$STORE_CACHE" -mmin +60 -print 2>/dev/null)" ]; then
    echo "Fetching store data..."
    curl -s "$PLUGIN_STORE_URL" > "$STORE_CACHE" 2>/dev/null || rm -f "$STORE_CACHE"
  else 
    echo "Using cached store data..."
  fi
}

# Get plugin download URL from store
get_store_url() {
  local plugin_name="$1"
  local hash=""
  
  if [ -f "$STORE_CACHE" ]; then
    if command -v jq &> /dev/null; then
      hash=$(jq -r --arg name "$plugin_name" '.[] | select(.name == $name) | .versions[0].hash' "$STORE_CACHE")
    else
      hash=$(grep -A 200 "\"name\":\"$plugin_name\"" "$STORE_CACHE" | grep -B 200 -m 1 "\"id\":" | grep -v "\"id\":" | grep -oP "\"hash\":\"[^\"]*\"" | head -1 | cut -d'"' -f4)
    fi
    
    if [ -n "$hash" ] && [ "$hash" != "null" ]; then
      echo "https://cdn.tzatzikiweeb.moe/file/steam-deck-homebrew/versions/${hash}.zip"
      return 0
    fi
  fi
  return 1
}

# Get plugin download URL from GitHub
get_github_url() {
  local repo="$1"
  local release_info
  release_info=$(curl -s "https://api.github.com/repos/$repo/releases/latest")
  local download_url
  download_url=$(echo "$release_info" | grep -o '"browser_download_url": "[^"]*\.zip"' | cut -d'"' -f4 | head -n 1)
  
  if [ -n "$download_url" ]; then
    echo "$download_url"
    return 0
  fi
  return 1
}

# Install plugin from downloaded zip
install_from_zip() {
  local plugin_name="$1"
  local zip_file="$2"
  
  [ ! -d "$PLUGIN_DIR" ] && mkdir -p "$PLUGIN_DIR"
  
  sudo unzip -qo "$zip_file" -d "$PLUGIN_DIR" || return 1
  rm -f "$zip_file"
  
  if [ ! -d "$PLUGIN_DIR/$plugin_name" ]; then
    local extracted
    extracted=$(find "$PLUGIN_DIR" -maxdepth 1 -type d -name "*$plugin_name*" | head -n 1)
    [ -n "$extracted" ] && sudo mv "$extracted" "$PLUGIN_DIR/$plugin_name"
  fi
  
  [ -d "$PLUGIN_DIR/$plugin_name" ] && return 0 || return 1
}

# Main plugin installation function
install_plugin() {
  local store_name="$1"
  local github_repo="$2"
  local plugin_name="$3"
  
  # Skip if already installed
  if [ -d "$PLUGIN_DIR/$plugin_name" ]; then
    echo "$plugin_name already installed"
    return 0
  fi
  
  local temp_zip="/tmp/$plugin_name.zip"
  local download_url=""
  
  # Try store method first
  download_url=$(get_store_url "$store_name")
  if [ -n "$download_url" ]; then
    echo "Installing $plugin_name from Decky store"
  else
    # Fall back to GitHub method
    echo "Store method failed, trying GitHub for $plugin_name"
    download_url=$(get_github_url "$github_repo")
    [ -z "$download_url" ] && echo "Failed to find download URL for $plugin_name" && return 1
  fi
  
  # Download and install
  curl -sL -o "$temp_zip" "$download_url" || return 1
  install_from_zip "$plugin_name" "$temp_zip"
}

# Fetch store data once
fetch_store_data

# Install requested plugins
install_plugin "HLTB for Deck" "hulkrelax/hltb-for-deck" "hltb-for-deck"
install_plugin "ProtonDB Badges" "OMGDuke/protondb-decky" "protondb-decky"
install_plugin "Decky-Framegen" "xXJSONDeruloXx/Decky-Framegen" "Decky-Framegen"