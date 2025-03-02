#!/bin/bash

APPLETSRC_CONFIG="$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc"

# Set Wallhaven as the wallpaper plugin using qdbus
qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "
    var Desktops = desktops();
    for (var i = 0; i < Desktops.length; i++) {
        var d = Desktops[i];
        d.wallpaperPlugin = 'com.plasma.wallpaper.wallhaven'; // Set Wallhaven as wallpaper engine
        d.currentConfigGroup = ['Wallpaper', 'com.plasma.wallpaper.wallhaven', 'General'];
        d.writeConfig('Image', '');
    }
"

CONTAINMENT_ID=""
CURRENT_CONTAINMENT=""

# Read the config file line by line
while IFS= read -r line; do
    if [[ "$line" =~ ^\[Containments\]\[([0-9]+)\]$ ]]; then
        CURRENT_CONTAINMENT="${BASH_REMATCH[1]}"
    elif [[ "$line" == "wallpaperplugin=com.plasma.wallpaper.wallhaven" ]]; then
        CONTAINMENT_ID="$CURRENT_CONTAINMENT"
        break
    fi
done < "$APPLETSRC_CONFIG"

if [[ -n "$CONTAINMENT_ID" ]]; then
    kwriteconfig6 --file "$APPLETSRC_CONFIG" \
                  --group "Containments" --group "$CONTAINMENT_ID" \
                  --group "Wallpaper" --group "com.plasma.wallpaper.wallhaven" \
                  --group "General" --key "Query" \
                  "Makoto Shinkai,Kimi no Na Wa,The Garden of Words,5 Centimeters Per Second,Studio Ghibli,Nier Automata,Nier,Life is Strange,Wall-E,Bioshock Infinite,Stellar Blade,Firewatch,Transistor,Erased"

    kwriteconfig6 --file "$APPLETSRC_CONFIG" \
                  --group "Containments" --group "$CONTAINMENT_ID" \
                  --group "Wallpaper" --group "com.plasma.wallpaper.wallhaven" \
                  --group "General" --key "WallpaperDelay" \
                  "1800"

    # Restart plasmashell silently
    ( sleep 1 && kquitapp6 plasmashell && sleep 2 && plasmashell --replace & ) >/dev/null 2>&1 &
fi