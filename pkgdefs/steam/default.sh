#!/bin/bash

source ./utils/file.sh

# https://wiki.archlinux.org/title/Steam
# https://wiki.archlinux.org/title/Gaming
sudo pacman -S --needed --noconfirm \
    steam steam-native-runtime

flatpak install -y flathub org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/24.08

# Steam Native libs. Taken from:
# - https://github.com/CachyOS/CachyOS-PKGBUILDS/blob/master/cachyos-gaming-meta/PKGBUILD
# - https://github.com/xerolinux/xlapit-cli/blob/main/xero-scripts/scripts/gaming.sh
# - (minus) https://archlinux.org/packages/multilib/x86_64/steam/
# - (minus) https://archlinux.org/packages/multilib/x86_64/steam-native-runtime/
# https://wiki.archlinux.org/title/Steam/Troubleshooting
# https://wiki.archlinux.org/title/Steam/Game-specific_troubleshooting
sudo pacman -S --needed --noconfirm \
    ttf-liberation wqy-zenhei \
    vkd3d lib32-vkd3d \
    giflib lib32-giflib \
    libpng lib32-libpng \
    libldap lib32-libldap \
    gnutls lib32-gnutls \
    mpg123 lib32-mpg123 \
    v4l-utils lib32-v4l-utils \
    sqlite lib32-sqlite \
    ncurses lib32-ncurses \
    ocl-icd lib32-ocl-icd \
    libxslt lib32-libxslt \
    gtk3 lib32-gtk3 \
    gst-plugins-base-libs lib32-gst-plugins-base-libs \
    glfw \
    opencl-icd-loader lib32-opencl-icd-loader

# Vapor theme
paru -S --noconfirm --needed plasma6-themes-vapor-steamos

sudo pacman -S --needed --noconfirm steamtinkerlaunch

source ./pkgdefs/steam/add-to-steam/default.sh

create_steam_minimal_shortcut() {
  local Mode=$1
  local mode="${1,,}"

  local desktop_file="$HOME/.local/share/applications/steam_minimal_${mode}.desktop"

  if [ ! -e "$desktop_file" ]; then
    mkdir -p "$HOME/.local/share/applications"
    cat > "$desktop_file" <<EOF
[Desktop Entry]
Type=Application
Name=Steam Minimal (${Mode})
Exec=/usr/bin/steam-${mode} -cef-disable-gpu-compositing -cef-disable-gpu steam://open/minigameslist %U
Categories=Network;FileTransfer;Game;
Icon=steam
Terminal=false
MimeType=x-scheme-handler/steam;x-scheme-handler/steamlink;
EOF
  fi
}

create_steam_minimal_shortcut "Runtime"
create_steam_minimal_shortcut "Native"

# https://wiki.archlinux.org/title/Improving_performance
echo "vm.max_map_count = 2147483642" | sudo tee /etc/sysctl.d/80-gamecompatibility.conf
sudo sysctl --system
