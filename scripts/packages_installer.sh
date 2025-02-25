#!/bin/bash

echo "Updating package list"
sudo dnf update

echo "Installing packages"
sudo dnf install -y \
    neovim \
    fastfetch \
    zsh \
    fzf 

echo "Changing shell to zsh. Write /bin/zsh"
sudo chsh $USER

echo "Log out and log back in again to use your new default shell"
