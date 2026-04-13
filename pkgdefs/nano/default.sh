sudo pacman -S --needed --noconfirm nano nano-syntax-highlighting

# /etc/nanorc
mkdir -p "$HOME/.config/nano"
cp -r -u -p ./pkgdefs/nano/nanorc "$HOME/.config/nano/nanorc"
