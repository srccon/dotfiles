# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "~/.zshrc"

autoload -Uz compinit
compinit

# End of lines added by compinstall

export PATH=$HOME/bin:/usr/local/bin:$PATH

COMPLETION_WAITING_DOTS="true"

source ~/.bashrc

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

source ~/.dotfiles/lib/pure/pure.zsh
source ~/.dotfiles/lib/pure/async.zsh
source ~/.dotfiles/lib/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh