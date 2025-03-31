#!/bin/bash

set -e

show_message() {
    local title="${1:-Steam}"
    local message="$2"
    local icon="${3:-/usr/share/icons/hicolor/48x48/apps/steam.png}"
    
    if [ "$ui" = "1" ]; then
        notify-send -a "$title" "$message" -i "$icon"
    else
        echo "$title: $message"
    fi
}

show_error() {
    local message="$1"
    
    if [ "$ui" = "1" ]; then
        notify-send -a "Steam" "$message" -i "/usr/share/icons/breeze/status/64/dialog-error.svg"
    else
        echo "$message" >&2
    fi
}

add_to_steam() {
    local file="$1"
    local title="${2:-$(basename "$file")}"
    local icon="$3"
    
    # encodedUrl="steam://addnonsteamgame/$(printf %s "$file" | jq -sRr @uri)"
    # touch /tmp/addnonsteamgamefile
    # steam -silent "$encodedUrl" & disown

    local cmd="steamtinkerlaunch addnonsteamgame --exepath=\"$file\" --appname=\"$title\""

    if [[ -n "$icon" ]]; then
        cmd+=" --iconpath=\"$icon\""
    fi

    eval "$cmd"
    
    show_message "$title" "Added to Steam" "$icon"
}

# Process command line arguments
if [ "$1" = "-ui" ]; then
    ui=1
    shift
fi

if [ -z "$1" ] || ! file=$(realpath "$1" 2>/dev/null) || [ ! -e "$file" ]; then
    show_error "Usage: add-to-steam [-ui] <path>"
    exit 1
fi

mime=$(kmimetypefinder "$file")
case "$mime" in
    "application/x-desktop")
        exec_cmd=$(grep -m 1 "^Exec=" "$file" | cut -d= -f2- | sed 's/ *%[fFuU]//g')
        icon=$(grep -m 1 "^Icon=" "$file" | cut -d= -f2-)
        name=$(grep -m 1 "^Name=" "$file" | cut -d= -f2-)

        add_to_steam "${exec_cmd:-$file}" "${name:-$(basename "$file")}" "$icon"
        ;;
    "application/x-executable"|"application/vnd.appimage"|"application/x-shellscript")
        # Make sure file is executable
        [ -x "$file" ] || chmod +x "$file"
        add_to_steam "$file"
        ;;
    "application/x-ms-dos-executable"|"application/x-msdownload"|"application/vnd.microsoft.portable-executable")
        add_to_steam "$file"
        ;;
    *)
        show_error "Unsupported file type: $mime"
        ;;
esac