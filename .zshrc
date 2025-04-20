### ---- ZSH HOME -----------------------------------
export ZSH=$HOME/.zsh
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:~/usr/bin/
export PATH=$PATH:~/.cargo/bin/
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export TERM=xterm-256color
export EDITOR=nvim
export TERMINAL=kitty
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_DESKTOP=Hyprland

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh


### 1 ---- Autocompletions ----------------------------------------
autoload -Uz compinit && compinit

### 2 ---- Completion options and styling -----------------------------------
zstyle ':completion:*' menu select # selectable menu
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]-_}={[:upper:][:lower:]_-}' 'r:|=*' 'l:|=* r:|=*'  # case insensitive completion
zstyle ':completion:*' special-dirs true # Complete . and .. special directories
zstyle ':completion:*' list-colors '' # colorize completion lists
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01' # colorize kill list

### 3 ---- Source other configs -----------------------------------
[[ -f $ZSH/config/history.zsh ]] && source $ZSH/config/history.zsh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ffb400,underline"

alias la="eza --icons -a --group-directories-first --git-ignore -l --no-permissions --no-time -h --git"
alias ll="eza --icons --group-directories-first --git-ignore -l --no-permissions --no-time -h --git"

### General ALIASES
alias upd="sudo dnf update && sudo dnf upgrade"
alias e="exit"
alias d="clear"
alias h="cd"
alias dot="cd ~/dotfiles/"
alias dd="cd ~/Developer/"
alias ddg="cd ~/Developer/GO/"
alias ddj="cd ~/Developer/JS/"
alias ddc="cd ~/Developer/C/"
alias ddcp="cd ~/Developer/Cpp/"
alias ddh="cd ~/Developer/Haskell/"
alias aus="cd ~/Documents/AUS/Segundo_year/primerC/"
alias mars="java -jar ~/Mars4_5.jar"
alias nn="cd ~/.config/nvim/"
alias b="cd .."
alias bb="cd ../.."
alias vi="nvim"
alias viz="nvim ~/.zshrc && source ~/.zshrc"
alias vik="nvim ~/.config/kitty/kitty.conf"
alias ff="fastfetch"
alias sdi="sudo dnf5 install"

alias gccw="gcc -Wall -Wextra -Wunused-variable -Wunused-parameter"
alias gppw="g++ -Wall -Wextra -Wunused-variable -Wunused-parameter"

### GIT ALIASES
alias gt="cat ~/tokenGITHUB.txt"
alias ga="git add"
alias gc="git commit -m"
alias gs="git status"
alias gl="git log"
alias gd="git diff"
alias gp="git push -u origin main"
alias gcl="git clone"
alias gch="git checkout"
alias gcm="git checkout main"
alias grn="git checkout -m master main"
alias gb="git branch"

export PATH="/home/linuxbrew/.linuxbrew/opt/openjdk@17/bin:$PATH"

# Created by `pipx` on 2024-04-19 20:41:58
export PATH="$PATH:/home/nickmdrummer/.local/bin"
export PATH="/home/linuxbrew/.linuxbrew/opt/jpeg/bin:$PATH"
eval "$(starship init zsh)"
#Homero gif
# gif-for-cli --display-mode=truecolor --cols 30 20045605

# Matrix gif
# gif-for-cli --display-mode=truecolor --cols 60 4011236

# Homero golpeando a nerd
# gif-for-cli --display-mode=truecolor --cols 60 17216871

# Homero Where's the any key?
# gif-for-cli --display-mode=truecolor --cols 50 14827444

# gif-for-cli --display-mode=truecolor --cols 60 17418719
# tai --colored --once --scale 2 --sleep 150 ~/Imágenes/homero.gif


# pnpm
export PNPM_HOME="/home/nickmdrummer/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


# Shell Wrapper for yazi: provides the ability to change the current working directory when exiting Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# detect SO and load correct packages
case "$(uname -s)" in
  Linux)
   source /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
   eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
   [ -f "/home/$USER/.ghcup/env" ] && . "/home/$USER/.ghcup/env" # ghcup-env
  ;;
  Darwin)
    eval "$(/usr/local/bin/brew shellenv)"
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    [ -f "/Users/nickmdrummer/.ghcup/env" ] && . "/Users/nickmdrummer/.ghcup/env" # ghcup-env
  ;;
esac

