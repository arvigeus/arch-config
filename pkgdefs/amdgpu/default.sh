#!/bin/bash

# https://wiki.archlinux.org/title/AMDGPU
# https://wiki.archlinux.org/title/Vulkan
sudo pacman -S --needed --noconfirm amd-ucode mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon amdvlk lib32-amdvlk mesa lib32-mesa vulkan-icd-loader lib32-vulkan-icd-loader vulkan-mesa-layers lib32-vulkan-mesa-layers fwupd
sudo pacman -S --needed --noconfirm rocm-opencl-runtime rocm-hip-runtime

mkdir -p "$HOME/.config/environment.d"
if ! grep -qxF 'AMD_VULKAN_ICD=RADV' "$HOME/.env"; then
    echo "AMD_VULKAN_ICD=RADV" > "$HOME/.config/environment.d/vulkan.conf"
    echo 'AMD_VULKAN_ICD=RADV' >> "$HOME/.env"
    # MESA_VK_DEVICE_SELECT=list vulkaninfo
    echo 'VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json' >> "$HOME/.env"
fi

# TODO: Mitigations off

systemctl --user daemon-reload
