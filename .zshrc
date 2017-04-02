#
# ~/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Import variables, and install 
source "$HOME/.dotfiles/.sshrc"

# Global Configs
for f in `ls $SHDIR/*`; do source $f; done

# Zsh Configs
for f in `ls $ZSHDIR/*`; do source $f; done
