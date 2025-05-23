#!/bin/bash

# https://wiki.archlinux.org/title/AMDGPU
# https://wiki.archlinux.org/title/Vulkan
sudo pacman -S --needed --noconfirm amd-ucode mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon amdvlk lib32-amdvlk mesa lib32-mesa vulkan-icd-loader lib32-vulkan-icd-loader vulkan-mesa-layers lib32-vulkan-mesa-layers fwupd
sudo pacman -S --needed --noconfirm rocm-opencl-runtime rocm-hip-runtime

# Monitoring tools
sudo pacman -S --needed --noconfirm radeontop nvtop

# Add the current user to the render group so the user has permission to run compute workloads (ROCm)
# https://rocm.docs.amd.com/projects/install-on-linux/en/latest/
sudo usermod -aG render "$USER"

mkdir -p "$HOME/.config/environment.d"
cp -u -p ./pkgdefs/amdgpu/env.conf "$HOME/.config/environment.d/vulkan.conf"
systemctl --user daemon-reexec

systemctl --user daemon-reload
