#!/bin/bash

source ./utils/file.sh

sudo pacman -S --needed --noconfirm eza

file_add_line "alias ls='eza --icons -F -H --group-directories-first --git -1'" "$HOME/.bashrc"

# shellcheck disable=SC1090
source ~/.bashrc