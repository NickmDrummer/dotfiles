HISTSIZE=10000000
HISTFILE=$ZSH/.zsh_history
SAVEHIST=10000000
setopt hist_expire_dups_first #delete duplicates when HISTFILE size exceeds
setopt appendhistory
setopt share_history
setopt hist_verify            # show command with history expansion to user before running it
setopt hist_ignore_all_dups
setopt hist_ignore_space
