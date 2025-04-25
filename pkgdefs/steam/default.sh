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

sudo pacman -S --needed --noconfirm game-devices-udev

source ./pkgdefs/steam/add-to-steam/default.sh

create_steam_minimal_shortcut() {
  local exec_path=$1
  local suffix=$2
  local display_name=$3

  local desktop_dir="$HOME/.local/share/applications"
  local desktop_file="${desktop_dir}/steam_minimal${suffix:+_${suffix}}.desktop"

  mkdir -p "$desktop_dir"

  cat > "$desktop_file" <<EOF
[Desktop Entry]
Type=Application
Name=${display_name}
Exec=${exec_path} -cef-disable-gpu-compositing -cef-disable-gpu steam://open/minigameslist %U
Categories=Network;FileTransfer;Game;
Icon=steam
Terminal=false
MimeType=x-scheme-handler/steam;x-scheme-handler/steamlink;
EOF
}

create_steam_minimal_shortcut "/usr/bin/steam" "" "Steam Minimal"
create_steam_minimal_shortcut "/usr/bin/steam-native" "native" "Steam Minimal (Native)"
cp -u -p ./pkgdefs/steam/steam_big_picture.desktop "$HOME/.local/share/applications/steam_big_picture.desktop"

# https://wiki.archlinux.org/title/Improving_performance
echo "vm.max_map_count = 2147483642" | sudo tee /etc/sysctl.d/80-gamecompatibility.conf
sudo sysctl --system
