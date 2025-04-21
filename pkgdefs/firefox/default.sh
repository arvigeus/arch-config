#!/bin/bash

sudo pacman -S --needed --noconfirm firefox

# TODO: Settings: https://github.com/arvigeus/nixos-config/blob/master/apps/firefox.nix

sudo pacman -S --needed --noconfirm arkenfox-user.js

PROFILE_DIR=$(grep 'Path=' ~/.mozilla/firefox/profiles.ini | sed 's/^Path=//' | head -n1)
FULL_PROFILE_PATH="${HOME}/.mozilla/firefox/${PROFILE_DIR}"
# Create user-overrides.js with custom prefs
[[ -f "${FULL_PROFILE_PATH}/user-overrides.js" ]] || install -Dm644 /dev/stdin "${FULL_PROFILE_PATH}/user-overrides.js" <<'EOF'
// Enable restoring previous session
user_pref("browser.startup.page", 3);
user_pref("browser.sessionstore.enabled", true);
user_pref("browser.sessionstore.privacy_level", 0);

// Use native XDG file picker
user_pref("widget.use-xdg-desktop-portal.file-picker", 1);

user_pref("dom.webgpu.enabled", true);
EOF

arkenfox-updater -s

source ./pkgdefs/browser-extensions/default.sh
install_browser_extensions "firefox"