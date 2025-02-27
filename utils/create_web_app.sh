#!/bin/bash

# Example usage:
# create_web_app "MyApp" "https://example.com"
# create_web_app "MyApp" "https://example.com" "AudioVideo;Audio;Video;"
create_web_app() {
    local app_name=$1
    local url=$2
    local categories=${3:-Network;Web;}
    local browser=${4:-chromium}
    local icon_dir="$HOME/.local/share/icons"
    local desktop_file="$HOME/.local/share/applications/$app_name.desktop"

    if [[ -z "$app_name" || -z "$url" ]]; then
        echo "Usage: create_web_app <app-name> <url> [browser]"
        return 1
    fi

    # Fetch and save the favicon
    local icon_file="$icon_dir/$app_name.png"
    mkdir -p "$icon_dir"

    local favicon_url
    favicon_url=$(curl -s "$url" | grep -oP '(?<=<link rel="icon" href=")[^"]+')

    if [[ -z "$favicon_url" ]]; then
        echo "No favicon found, using default."
        favicon_url="https://www.google.com/s2/favicons?domain=$(echo "$url" | awk -F/ '{print $3}')"
    fi

    # Handle relative URLs
    if [[ "$favicon_url" != http* ]]; then
        local base_url
        base_url=$(echo "$url" | awk -F/ '{print $1 "//" $3}')
        favicon_url="$base_url$favicon_url"
    fi

    curl -s "$favicon_url" -o "$icon_file"
    convert "$icon_file" -resize 64x64 "$icon_file" 2>/dev/null || echo "Failed to process favicon, using as-is."

    # Create the .desktop file
    cat <<EOF > "$desktop_file"
[Desktop Entry]
Name=$app_name
Exec=$browser --app="$url"
Icon=$icon_file
Type=Application
Categories=$categories
EOF

    chmod +x "$desktop_file"
}