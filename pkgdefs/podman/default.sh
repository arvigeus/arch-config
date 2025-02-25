#!/bin/bash

# https://wiki.archlinux.org/title/Podman
sudo pacman -S --needed --noconfirm podman-docker docker-compose podman-compose
#flatpak install -y flathub io.podman_desktop.PodmanDesktop
flatpak install -y flathub com.github.marhkb.Pods

if ! grep -q "DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock" "$HOME/.env"; then
    echo 'DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock' >> "$HOME/.env"
    # echo 'PODMAN_COMPOSE_PROVIDER=podman-compose' >> "$HOME/.env"
fi
