#!/bin/bash

if ! grep -q "\[g14\]" /etc/pacman.conf; then
    # https://asus-linux.org/guides/arch-guide/
    sudo pacman-key --recv-keys 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
    sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
    sudo pacman-key --lsign-key 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
    sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
    echo -e "\n[g14]\nServer = https://arch.asus-linux.org\n" | sudo tee -a /etc/pacman.conf
    sudo pacman -Suy --noconfirm
fi

# Provides Armory Crate
sudo pacman -S --needed --noconfirm linux-g14 linux-g14-headers
# Provides much better support in general
sudo pacman -S --needed --noconfirm linux-bazzite-bin


sudo pacman -S --needed --noconfirm asusctl rog-control-center power-profiles-daemon supergfxctl switcheroo-control
sudo systemctl enable --now power-profiles-daemon.service
sudo systemctl enable --now supergfxd
sudo systemctl enable --now switcheroo-control

mkdir -p "$HOME/.config/autostart"
if [ ! -L "$SYMLINK" ]; then
    ln -s /usr/share/applications/rog-control-center.desktop "$HOME/.config/autostart/rog-control-center.desktop"
fi
mkdir -p "$HOME/.config/rog/"
cp -u -p ./pkgdefs/asus-laptop/config/rog-control-center.cfg "$HOME/.config/rog/rog-control-center.cfg"


sudo pacman -S --needed --noconfirm lact
sudo systemctl enable --now lactd

sudo pacman -S --needed --noconfirm linux-headers
sudo pacman -S --needed --noconfirm ryzenadj ryzen_smu-dkms-git
# https://gitlab.com/leogx9r/ryzen_smu
echo "ryzen_smu" | sudo tee /etc/modules-load.d/ryzen_smu.conf
# Needs restart
# Test: sudo ryzenadj --info

mkdir -p "$HOME/.local/bin/"
cp -u -p ./pkgdefs/asus-laptop/performance_profile.sh "$HOME/.local/bin/performance_profile"
cp -u -p ./pkgdefs/asus-laptop/set-tdp.sh "$HOME/.local/bin/set-tdp"
