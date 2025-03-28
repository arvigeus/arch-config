#!/bin/bash

# https://wiki.archlinux.org/title/Podman
sudo pacman -S --needed --noconfirm podman-docker docker-compose podman-compose
#flatpak install -y flathub io.podman_desktop.PodmanDesktop
flatpak install -y flathub com.github.marhkb.Pods

mkdir -p "$HOME/.config/environment.d"
echo "DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock" > "$HOME/.config/environment.d/podman.conf"
# echo "PODMAN_COMPOSE_PROVIDER=podman-compose" >> "$HOME/.config/environment.d/podman.conf"
echo "" >> "$HOME/.config/environment.d/podman.conf"
systemctl --user daemon-reexec