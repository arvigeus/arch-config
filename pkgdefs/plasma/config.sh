#!/bin/bash

# Check if running as root, which we don't want for user configs
if [ "$EUID" -eq 0 ]; then
    echo "Please don't run this script as root. It configures user-level settings."
    exit 1
fi

# Power Management
kwriteconfig6 --file powerdevilrc --group "AC" --group "Performance" --key "PowerProfile" "balanced"
kwriteconfig6 --file powerdevilrc --group "AC" --group "RunScript" --key "ProfileLoadCommand" "/home/arvigeus/.local/bin/performance_profile balanced\n"
kwriteconfig6 --file powerdevilrc --group "AC" --group "RunScript" --key "ProfileUnloadCommand" "/home/arvigeus/.local/bin/performance_profile powersave"
kwriteconfig6 --file powerdevilrc --group "AC" --group "SuspendAndShutdown" --key "AutoSuspendAction" "0"
kwriteconfig6 --file powerdevilrc --group "AC" --group "SuspendAndShutdown" --key "LidAction" "64"

kwriteconfig6 --file powerdevilrc --group "Battery" --group "Performance" --key "PowerProfile" "power-saver"
kwriteconfig6 --file powerdevilrc --group "Battery" --group "SuspendAndShutdown" --key "AutoSuspendIdleTimeoutSec" "1800"

# Workspace
kwriteconfig6 --file kdeglobals --group KDE --key SingleClick true

# Configure workspace settings
kwriteconfig6 --file "dolphinrc" --group "General" --type=bool --key "BrowseThroughArchives" "true"

# Configure ksmserverrc
kwriteconfig6 --file "ksmserverrc" --group "General" --key "loginMode" "emptySession"

# Configure kdeglobals
# kwriteconfig6 --file "kdeglobals" --group "General" --type=bool --key "accentColorFromWallpaper" "true"

# Configure screen locker
kwriteconfig6 --file "kscreenlockerrc" --group "Daemon" --type=bool --key "Autolock" "false"
kwriteconfig6 --file "kscreenlockerrc" --group "Daemon" --type=int --key "Timeout" "0"
kwriteconfig6 --file "kscreenlockerrc" --group "Greeter" --key "WallpaperPlugin" "com.plasma.wallpaper.wallhaven"
kwriteconfig6 --file "kscreenlockerrc" --group "Greeter" --group "Wallpaper" --group "com.plasma.wallpaper.wallhaven" --group "General" --key "WallpaperDelay" "1800"
# kwriteconfig6 --file "kscreenlockerrc" --group "Greeter" "WallpaperPlugin" "org.kde.potd"
# kwriteconfig6 --file "kscreenlockerrc" --group "Greeter" --group "Wallpaper" --group "org.kde.potd" --group "General" "Provider" "bing"

# Disable Overview effect on screen border
kwriteconfig6 --file "kwinrc" --group "Effect-overview" --type=int --key "BorderActivate" "9"

# # Configure splash screen
kwriteconfig6 --file "ksplashrc" --group "KSplash" --key "Engine" "none"

# # Configure wallet
kwriteconfig6 --file "kwalletrc" --group "Wallet" --type=bool --key "First Use" "false"

# Configure kwin rules for firefox picture-in-picture
kwriteconfig6 --file "kwinrulesrc" --group "1" --key "Description" "Window settings for firefox"
kwriteconfig6 --file "kwinrulesrc" --group "1" --type=bool --key "above" "true"
kwriteconfig6 --file "kwinrulesrc" --group "1" --type=int --key "aboverule" "2"
kwriteconfig6 --file "kwinrulesrc" --group "1" --key "position" "1280,842"
kwriteconfig6 --file "kwinrulesrc" --group "1" --type=int --key "positionrule" "4"
kwriteconfig6 --file "kwinrulesrc" --group "1" --key "size" "768,384"
kwriteconfig6 --file "kwinrulesrc" --group "1" --type=int --key "sizerule" "4"
kwriteconfig6 --file "kwinrulesrc" --group "1" --type=bool --key "skiptaskbar" "true"
kwriteconfig6 --file "kwinrulesrc" --group "1" --type=int --key "skiptaskbarrule" "2"
kwriteconfig6 --file "kwinrulesrc" --group "1" --key "title" "Picture-in-Picture"
kwriteconfig6 --file "kwinrulesrc" --group "1" --type=int --key "titlematch" "1"
kwriteconfig6 --file "kwinrulesrc" --group "1" --type=int --key "types" "1"
kwriteconfig6 --file "kwinrulesrc" --group "1" --key "wmclass" "firefox"
kwriteconfig6 --file "kwinrulesrc" --group "1" --type=int --key "wmclassmatch" "1"

# Configure kwin rule with UUID (might need to be regenerated if you want it to be truly unique)
kwriteconfig6 --file "kwinrulesrc" --group "78315bde-2c1a-488f-bbee-7b8dfbf4cc3a" --key "Description" "Window settings for firefox"
kwriteconfig6 --file "kwinrulesrc" --group "78315bde-2c1a-488f-bbee-7b8dfbf4cc3a" --type=bool --key "above" "true"
kwriteconfig6 --file "kwinrulesrc" --group "78315bde-2c1a-488f-bbee-7b8dfbf4cc3a" --type=int --key "aboverule" "3"
kwriteconfig6 --file "kwinrulesrc" --group "78315bde-2c1a-488f-bbee-7b8dfbf4cc3a" --key "position" "1353,833"
kwriteconfig6 --file "kwinrulesrc" --group "78315bde-2c1a-488f-bbee-7b8dfbf4cc3a" --type=int --key "positionrule" "4"
kwriteconfig6 --file "kwinrulesrc" --group "78315bde-2c1a-488f-bbee-7b8dfbf4cc3a" --key "size" "683,384"
kwriteconfig6 --file "kwinrulesrc" --group "78315bde-2c1a-488f-bbee-7b8dfbf4cc3a" --type=int --key "sizerule" "4"
kwriteconfig6 --file "kwinrulesrc" --group "78315bde-2c1a-488f-bbee-7b8dfbf4cc3a" --key "title" "Picture-in-Picture"
kwriteconfig6 --file "kwinrulesrc" --group "78315bde-2c1a-488f-bbee-7b8dfbf4cc3a" --type=int --key "titlematch" "1"
kwriteconfig6 --file "kwinrulesrc" --group "78315bde-2c1a-488f-bbee-7b8dfbf4cc3a" --type=int --key "types" "1"
kwriteconfig6 --file "kwinrulesrc" --group "78315bde-2c1a-488f-bbee-7b8dfbf4cc3a" --key "wmclass" "firefox"
kwriteconfig6 --file "kwinrulesrc" --group "78315bde-2c1a-488f-bbee-7b8dfbf4cc3a" --type=bool --key "wmclasscomplete" "true"
kwriteconfig6 --file "kwinrulesrc" --group "78315bde-2c1a-488f-bbee-7b8dfbf4cc3a" --type=int --key "wmclassmatch" "1"

# Configure kwin rule general settings
kwriteconfig6 --file "kwinrulesrc" --group "General" --type=int --key "count" "1"
kwriteconfig6 --file "kwinrulesrc" --group "General" --type=int --key "rules" "1"

# Configure keyboard layouts
kwriteconfig6 --file "kxkbrc" --group "Layout" --key "DisplayNames" ","
kwriteconfig6 --file "kxkbrc" --group "Layout" --key "LayoutList" "us,bg"
kwriteconfig6 --file "kxkbrc" --group "Layout" --key "Options" "terminate:ctrl_alt_bksp,grp:alt_shift_toggle"
kwriteconfig6 --file "kxkbrc" --group "Layout" --type=bool --key "ResetOldOptions" "true"
kwriteconfig6 --file "kxkbrc" --group "Layout" --key "SwitchMode" "Window"
kwriteconfig6 --file "kxkbrc" --group "Layout" --type=bool --key "Use" "true"
kwriteconfig6 --file "kxkbrc" --group "Layout" --key "VariantList" ",phonetic"

# Configure locale
kwriteconfig5 --file "plasma-localerc" --group "Formats" --key "LANG" "en_US.UTF-8"

# Shortcuts
if [ ! -e "$HOME/.local/share/applications/rofi_menu.desktop" ]; then
    mkdir -p "$HOME/.local/share/applications"
    cat > "$HOME/.local/share/applications/rofi_menu.desktop" <<EOF
[Desktop Entry]
Exec=/home/arvigeus/.local/bin/rofi_menu
Name=rofi_menu
NoDisplay=true
Type=Application
EOF
fi
kwriteconfig6 --file kglobalshortcutsrc --group "services" --group "rofi_menu.desktop" --key "_launch" "Meta+Space"

cp -u -p ./pkgdefs/plasma/plasma-org.kde.plasma.desktop-appletsrc "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc"

# Restart plasmashell to apply changes
(sleep 1 && kquitapp6 plasmashell && sleep 2 && plasmashell --replace &) >/dev/null 2>&1 &
