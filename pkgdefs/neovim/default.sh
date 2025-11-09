sudo pacman -S --needed --noconfirm neovim ripgrep

mkdir -p "$HOME/.config/nvim/"
cp -r -u -p ./pkgdefs/neovim/config/. "$HOME/.config/nvim/"