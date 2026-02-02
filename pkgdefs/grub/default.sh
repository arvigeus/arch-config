#!/bin/bash

# TODO: Switching to systemd init with disk encryption
# /etc/default/grub:
#   - GRUB_CMDLINE_LINUX: change `cryptdevice=UUID=<uuid>:<name>` to `rd.luks.name=<uuid>=<name>` (replaced `cryptdevice=UUID` with `rd.luks.name` and `:<name>` with `=<name>`)
#   - GRUB_CMDLINE_LINUX_DEFAULT: add `splash`

sudo sed -i 's|^GRUB_DEFAULT=.*|GRUB_DEFAULT="Advanced options for Arch Linux>Arch Linux, with Linux linux-g14"|' /etc/default/grub
# NOTE: Setting GRUB_TIMEOUT to 0 disables pressing Shift to show the menu.
sudo sed -i 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=1/' /etc/default/grub
sudo sed -i 's/^GRUB_TIMEOUT_STYLE=.*/GRUB_TIMEOUT_STYLE=hidden/' /etc/default/grub
sudo sed -i 's|^GRUB_CMDLINE_LINUX_DEFAULT=.*|GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet splash mitigations=off"|' /etc/default/grub

sudo cp -u -p ./pkgdefs/grub/update-grub.sh /usr/sbin/update-grub
sudo chmod +x /usr/sbin/update-grub

# THEME
sudo pacman -S --needed --noconfirm imagemagick
[[ -d /boot/grub/themes/bgrt-grub-theme ]] && sudo rm -rf /boot/grub/themes/bgrt-grub-theme
TMP=$(mktemp -d)
git clone https://github.com/arvigeus/bgrt-grub-theme.git "$TMP"
chmod +x "$TMP/install.sh"
(cd "$TMP" && sudo ./install.sh)
rm -rf "$TMP"
# GRUB is updated by theme installation, but update-grub applies some manual tweaks
sudo update-grub
