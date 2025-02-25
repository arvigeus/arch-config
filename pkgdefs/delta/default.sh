#!/bin/bash

sudo pacman -S --needed --noconfirm git-delta diffutils

# mkdir -p "$HOME/.config/environment.d"
# if ! grep -q 'DIFFPROG=delta' "$HOME/.env"; then
#     echo 'DIFFPROG="delta --side-by-side --line-numbers"' > "$HOME/.config/environment.d/diffprog.conf"
#     echo 'DIFFPROG="delta --side-by-side --line-numbers"' >> "$HOME/.env"
# fi
