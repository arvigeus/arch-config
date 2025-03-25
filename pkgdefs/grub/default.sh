#!/bin/bash

# TODO: Switching to systemd init with disk encryption
# /etc/default/grub:
#   - GRUB_CMDLINE_LINUX: change `cryptdevice=UUID=<uuid>:<name>` to `rd.luks.name=<uuid>=<name>` (replaced `cryptdevice=UUID` with `rd.luks.name` and `:<name>` with `=<name>`)
#   - GRUB_CMDLINE_LINUX_DEFAULT: add `splash`

sudo sed -i 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=3/' /etc/default/grub
sudo sed -i 's/^GRUB_TIMEOUT_STYLE=.*/GRUB_TIMEOUT_STYLE=hidden/' /etc/default/grub
sudo sed -i 's|^GRUB_CMDLINE_LINUX_DEFAULT=.*|GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet splash mitigations=off"|' /etc/default/grub

sudo cp -u -p ./pkgdefs/grub/update-grub.sh /usr/sbin/update-grub

sudo update-grub
