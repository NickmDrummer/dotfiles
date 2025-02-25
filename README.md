# dotfiles

This is my personal dotfiles repository.

## Requirements

- git
- stow

## Installation

Install git and stow. On Fedora, this can be done with the following command.
```
sudo dnf install git stow
```
Clone this repository into your home directory.
```
git clone https://github.com/NickmDrummer/dotfiles ~/dotfiles
cd dotfiles
```
Then use GNU stow to create symlinks to the files in this repository.
```
stow . 
```

### Scripts

Inside the dotfiles directory you will find a folder called `scripts`. This folder contains scripts that are used to install and configure the next packages:

Run in order with `sh [script name].sh`.

- `packages_installer.sh`: zsh, neovim, fastfetch, fzf.
- `brewpackages.sh`: Homebrew, Yazi and Maple Mono Font (Nerd Font).
- `kittyInstall.sh`: Kitty Terminal.


### Reference

- [youtube video](https://youtu.be/y6XCebnB9gs?si=YAik6reUHF-HyErJ)
