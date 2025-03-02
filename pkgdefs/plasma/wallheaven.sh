#!/bin/bash

APPLETSRC_CONFIG="$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc"

# Get a list of all containments using grep and regex
# This extracts all containment IDs from section headers that match [Containments][X]
containment_ids=$(grep -o '^\[Containments\]\[[0-9]\+\]$' "$APPLETSRC_CONFIG" | grep -o '[0-9]\+')

for id in $containment_ids; do
    wallpaper_plugin=$(kreadconfig6 --file "$APPLETSRC_CONFIG" \
                     --group "Containments" --group "$id" \
                     --key "wallpaperplugin" 2>/dev/null)
    
    plugin=$(kreadconfig6 --file "$APPLETSRC_CONFIG" \
                       --group "Containments" --group "$id" \
                       --key "plugin" 2>/dev/null)
    
    if [ -n "$wallpaper_plugin" ] && { [ "$plugin" = "org.kde.plasma.folder" ] || [ "$plugin" = "org.kde.desktopcontainment" ]; }; then
        kwriteconfig6 --file "$APPLETSRC_CONFIG" \
                     --group "Containments" --group "$id" \
                     --key "plugin" "org.kde.desktopcontainment"
                     
        kwriteconfig6 --file "$APPLETSRC_CONFIG" \
                     --group "Containments" --group "$id" \
                     --key "wallpaperplugin" "com.plasma.wallpaper.wallhaven"
        
        kwriteconfig6 --file "$APPLETSRC_CONFIG" \
                     --group "Containments" --group "$id" \
                     --group "Wallpaper" --group "com.plasma.wallpaper.wallhaven" \
                     --group "General" --key "Query" \
                     "landscape mountains"
        
        kwriteconfig6 --file "$APPLETSRC_CONFIG" \
                     --group "Containments" --group "$id" \
                     --group "Wallpaper" --group "com.plasma.wallpaper.wallhaven" \
                     --group "General" --key "WallpaperDelay" \
                     "1800"
    fi
done

# Restart plasmashell to apply changes
( sleep 1 && kquitapp6 plasmashell && sleep 2 && plasmashell --replace & ) >/dev/null 2>&1 &