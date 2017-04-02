#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Import variables (all following calls will be with variables calls)
source "$HOME/.dotfiles/.sshrc"

# Global Configs
for f in `ls $SHDIR/*`; do source $f; done

# Bash Configs
for f in `ls $BASHDIR/*`; do source $f; done
