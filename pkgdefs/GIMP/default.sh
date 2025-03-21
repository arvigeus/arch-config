#!/bin/bash

# Check for newer versions:
# flatpak search org.gimp.GIMP

# TODO: Install missing plugins once they are available
flatpak install -y flathub org.gimp.GIMP
flatpak install -y flathub org.gimp.GIMP.Plugin.Resynthesizer/x86_64/3
#flatpak install -y flathub org.gimp.GIMP.Plugin.Lensfun/x86_64/3
flatpak install -y flathub org.gimp.GIMP.Plugin.Fourier/x86_64/3
#flatpak install -y flathub org.gimp.GIMP.Plugin.BIMP/x86_64/3
#flatpak install -y flathub org.gimp.GIMP.Plugin.LiquidRescale/x86_64/3
#flatpak install -y flathub org.gimp.GIMP.Plugin.FocusBlur/x86_64/3
flatpak install -y flathub org.gimp.GIMP.Plugin.GMic/x86_64/3

