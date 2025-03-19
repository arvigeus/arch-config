#!/bin/bash

# Creates isolated web applications with dedicated browser profiles
# Usage: create_web_app "AppName" "https://example.com" ["Network;Web;"] ["chromium"]
# Based on: https://github.com/linuxmint/webapp-manager/blob/master/usr/lib/webapp-manager/common.py
create_web_app() {
    # Parse arguments with defaults
    local app_name=$1
    local url=$2
    local categories=${3:-Network;Web;}
    local browser=${4:-chromium}
    
    # Validate required arguments
    if [[ -z "$app_name" || -z "$url" ]]; then
        echo "Usage: create_web_app <app-name> <url> [categories] [browser]"
        return 1
    fi
    
    # Set up directory structure
    local codename; codename="${app_name//[^a-zA-Z]}"
    local base_dir="$HOME/.local/share/webapps/$app_name"
    local icons_dir="$base_dir"
    local profiles_dir="$base_dir/profile"
    local apps_dir="$HOME/.local/share/applications"
    
    # Create directories
    mkdir -p "$icons_dir" "$profiles_dir" "$apps_dir"
    
    # File paths
    local icon_file="$icons_dir/icon.png"
    local desktop_file="$apps_dir/$app_name.desktop"
    
    # Fetch favicon
    fetch_icon "$url" "$icon_file"
    
    # Configure browser-specific settings and create desktop file
    local exec_string; exec_string=$(build_exec_string "$browser" "$url" "$codename" "$profiles_dir" "$icon_file")
    create_desktop_file "$desktop_file" "$app_name" "$exec_string" "$icon_file" "$categories" "$codename" "$url"
}

fetch_icon() {
    local url=$1
    local icon_file=$2
    local domain; domain=$(echo "$url" | awk -F/ '{print $3}')

    # Try Google's favicon service first (high quality)
    wget -q -O "$icon_file" "https://www.google.com/s2/favicons?sz=64&domain=$domain"

}

build_exec_string() {
    local browser=$1
    local url=$2
    local codename=$3
    local profile_path=$4
    local icon_file=$5
    
    # Handle browser-specific configuration
    if [[ "$browser" =~ chrome|chromium|brave|edge|vivaldi ]]; then
        # Chromium-based browsers
        echo "$browser --app=\"$url\" --class=WebApp-$codename --user-data-dir=\"$profile_path\""
    elif [[ "$browser" =~ firefox|librewolf|waterfox ]]; then
        # Firefox-based browsers
        mkdir -p "$profile_path/chrome"
        
        # Create Firefox configuration files
        echo "@namespace url(\"http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul\");
#nav-bar { visibility: collapse !important; }" > "$profile_path/chrome/userChrome.css"
        
        echo "user_pref(\"toolkit.legacyUserProfileCustomizations.stylesheets\", true);" > "$profile_path/user.js"
        
        echo "sh -c 'XAPP_FORCE_GTKWINDOW_ICON=\"$icon_file\" $browser --class WebApp-$codename --profile \"$profile_path\" --no-remote \"$url\"'"
    else
        # Default fallback
        echo "$browser --app=\"$url\""
    fi
}

create_desktop_file() {
    local file=$1
    local name=$2
    local exec=$3
    local icon=$4
    local categories=$5
    local codename=$6
    local url=$7
    
    cat > "$file" <<EOF
[Desktop Entry]
Version=1.0
Name=$name
Comment=Web App
Exec=$exec
Terminal=false
Type=Application
Icon=$icon
Categories=$categories
MimeType=text/html;text/xml;application/xhtml_xml;
StartupWMClass=WebApp-$codename
StartupNotify=true
X-WebApp-URL=$url
X-WebApp-Isolated=true
EOF
    
    chmod +x "$file"
}