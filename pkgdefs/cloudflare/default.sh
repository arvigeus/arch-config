#!/bin/bash

grep -qxF '185.199.108.154 github.githubassets.com' /etc/hosts || echo '185.199.108.154 github.githubassets.com' | sudo tee -a /etc/hosts > /dev/null

# cloudflare-warp-bin has problem with logging out DE
paru -S --noconfirm --needed cloudflare-warp-nox-bin
sudo systemctl enable warp-svc.service --now

sleep 3

# Add local network ranges to split tunnel
# This allows apps like KDE Connect to function
warp-cli tunnel ip add-range 192.168.0.0/16
warp-cli tunnel ip add-range 172.16.0.0/12
warp-cli tunnel ip add-range 10.0.0.0/8
# Check configuration
# warp-cli tunnel ip list
# Remove range
# warp-cli tunnel ip remove-range 192.168.0.0/16
# warp-cli tunnel ip remove-range 172.16.0.0/12
# warp-cli tunnel ip remove-range 10.0.0.0/8

warp-cli registration new
warp-cli connect

sleep 3
