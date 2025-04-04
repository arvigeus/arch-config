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

source ./pkgdefs/plasma/theme/sddm/default.sh

source ./pkgdefs/plasma/theme/sddm/default.sh

# Copy the color scheme file
mkdir -p "$HOME/.local/share/konsole"
cp ./pkgdefs/plasma/theme/konsole/DarkOcean.colorscheme "$HOME/.local/share/konsole/DarkOcean.colorscheme"

# Darkly
kwriteconfig6 --file darklyrc --group "Common" --key "CornerRadius" 2
kwriteconfig6 --file darklyrc --group "Style" --key "TabBarAltStyle" true
kwriteconfig6 --file darklyrc --group "Style" --key "WidgetDrawShadow" false

# Look and Feel - splash, settings, layouts
mkdir -p "$HOME/.local/share/plasma/look-and-feel/DarkOcean"
cp -r ./pkgdefs/plasma/theme/look-and-feel/* "$HOME/.local/share/plasma/look-and-feel/DarkOcean"

lookandfeeltool -a DarkOcean --resetLayout
