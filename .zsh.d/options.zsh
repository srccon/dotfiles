unsetopt beep
zstyle :compinstall filename "~/.zshrc"
autoload -Uz compinit
bindkey '^R' history-incremental-search-backward
compinit

