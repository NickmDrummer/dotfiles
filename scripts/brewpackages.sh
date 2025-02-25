#!/bin/bash

echo "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Instaliing yazi"
brew install yazi ffmpeg sevenzip jq poppler fd ripgrep fzf zoxide imagemagick

echo "Installing starship prompt"
curl -sS https://starship.rs/install.sh | sh

echo "Installing Maple Mono Font"
brew install --cask font-maple-mono-nf
