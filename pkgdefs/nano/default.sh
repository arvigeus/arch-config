sudo pacman -S --needed --noconfirm nano nano-syntax-highlighting

# /etc/nanorc
mkdir -p "$HOME/.config/nano"

# https://www.nano-editor.org/dist/latest/nanorc.5.html
cp -r -u -p ./pkgdefs/nano/nanorc "$HOME/.config/nano/nanorc"
