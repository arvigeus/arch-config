#!/bin/bash

paru -S --noconfirm --needed cloudflare-warp-bin
sudo systemctl enable warp-svc.service --now
sleep 1
warp-cli connect