#!/bin/bash

echo "Updating package list"
sudo dnf update

echo "Installing packages"
sudo dnf install -y \
    neovim \
    fastfetch \
    zsh \
    fzf 

echo "Installing Starship prompt"
curl -sS https://starship.rs/install.sh | sh

echo "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Installing fast-syntax-highlighting"
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/path/to/fsh

echo "Changing shell to zsh. Write /bin/zsh"
sudo chsh $USER

echo "Log out and log back in again to use your new default shell"
