unsetopt beep
bindkey -v
zstyle :compinstall filename "~/.zshrc"
autoload -Uz compinit
bindkey '^R' history-incremental-search-backward
compinit

