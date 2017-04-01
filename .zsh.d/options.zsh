unsetopt beep
bindkey -v
zstyle :compinstall filename "~/.zshrc"
autoload -Uz compinit
compinit
