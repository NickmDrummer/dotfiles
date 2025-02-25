#!/bin/bash

echo "Updating package list"
sudo dnf update

echo "Installing packages"
sudo dnf install -y \
    neovim \
    fastfetch \
    zsh \
    fzf 
