#!/bin/bash

# https://wiki.archlinux.org/title/Steam
# https://wiki.archlinux.org/title/Gaming
# https://wiki.archlinux.org/title/Improving_performance
# https://wiki.archlinux.org/title/Gamescope
sudo pacman -S --needed --noconfirm steam steam-native-runtime gamemode gamescope mangohud lib32-mangohud goverlay seatd ttf-liberation lib32-fontconfig wqy-zenhei vkd3d lib32-vkd3d giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama libgcrypt lib32-libgcrypt ncurses lib32-ncurses ocl-icd lib32-ocl-icd libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader cups dosbox lib32-opencl-icd-loader opencl-icd-loader

flatpak install -y flathub com.valvesoftware.Steam
flatpak install -y flathub org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/24.08

echo "vm.max_map_count = 2147483642" | sudo tee /etc/sysctl.d/80-gamecompatibility.conf

if ! grep -qxF 'SteamDeck=1' "$HOME/.env"; then
    echo 'SteamDeck=1' >> "$HOME/.env"
fi

sudo sysctl --system
