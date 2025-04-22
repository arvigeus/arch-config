#!/bin/bash

sudo pacman -S --needed --noconfirm firefox

source ./pkgdefs/browser-extensions/default.sh
install_browser_extensions "firefox"

sleep 5 # Need to wait to open browser tabs
grep '^Path=' "$HOME/.mozilla/firefox/profiles.ini" | sed 's/^Path=//' | while read -r profile; do
  cp -u -p ./pkgdefs/firefox/user.js "$HOME/.mozilla/firefox/$profile/user.js"
done

# TODO: Add search engines - about:preferences#search (https://superuser.com/a/1756774/204761)
# https://wiki.archlinux.org/index.php?search=%s
# https://aur.chaotic.cx/packages?search=%s
# https://aur.archlinux.org/packages?K=%s
# https://archlinux.org/packages/?q=%s
# https://www.kagi.com/search?q=%s
# https://www.ecosia.org/search?q=%s
# https://sourcegraph.com/search?q=context:global+fork:no+%s