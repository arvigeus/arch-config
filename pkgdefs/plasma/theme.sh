#!/bin/bash

# Copy the Plasma theme directory
mkdir -p "$HOME/.local/share/plasma/desktoptheme"
cp -r ./pkgdefs/plasma/theme/Plasma/ "$HOME/.local/share/plasma/desktoptheme/DarkOcean/"

# Copy the Window Decorations directory
mkdir -p "$HOME/.local/share/aurorae/themes"
cp -r ./pkgdefs/plasma/theme/WindowDecorations/ "$HOME/.local/share/aurorae/themes/DarkOcean/"

# Copy the color scheme file
mkdir -p "$HOME/.local/share/color-schemes"
cp ./pkgdefs/plasma/theme/DarkOcean.colors "$HOME/.local/share/color-schemes/DarkOcean.colors"

# Copy the color scheme file
mkdir -p "$HOME/.local/share/konsole"
cp ./pkgdefs/plasma/theme/konsole/DarkOcean.colorscheme "$HOME/.local/share/konsole/DarkOcean.colorscheme"
