#!/bin/bash

# https://wiki.archlinux.org/title/Mkinitcpio#Possibly_missing_firmware_for_module_XXXX
## NOTE: Possibly missing firmware for module: 'qat_420xx'
## See more: https://aur.archlinux.org/packages/mkinitcpio-firmware
sudo pacman -S --needed --noconfirm linux-firmware linux-firmware-qlogic
paru -S --noconfirm --needed upd72020x-fw wd719x-firmware ast-firmware aic94xx-firmware

# TODO: Enable GPU and plymouth, switch from busybox init to systemd init
# MODULES=(btrfs amdgpu)
# HOOKS=(systemd plymouth autodetect microcode modconf kms keyboard sd-vconsole block sd-encrypt filesystems fsck grub-btrfs-overlayfs)
# sudo mkinitcpio -P