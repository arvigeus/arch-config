#!/bin/bash

# TODO: Switching to systemd init with disk encryption
# /etc/default/grub:
#   - GRUB_CMDLINE_LINUX: change `cryptdevice=UUID=<uuid>:<name>` to `rd.luks.name=<uuid>=<name>` (replaced `cryptdevice=UUID` with `rd.luks.name` and `:<name>` with `=<name>`)
#   - GRUB_CMDLINE_LINUX_DEFAULT: add `splash`

# TODO: Hide menu:
# GRUB_TIMEOUT_STYLE=hidden

# TODO: Reduce countdown
# GRUB_TIMEOUT=3

# TODO: mitigations: off
# GRUB_CMDLINE_LINUX_DEFAULT: add `mitigations=off`

# sudo grub-mkconfig -o /boot/grub/grub.cfg
