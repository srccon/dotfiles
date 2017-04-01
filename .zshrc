#
# ~/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Import variables (all following calls will be with variables calls)
source "$HOME/.dotfiles/vars"

# Install/update Dependencies (my faves)
source $INSTALLDIR/installdeps.sh
source $INSTALLDIR/installdotfiles.sh

# Global Configs
for f in `ls $SHDIR/*`; do source $f; done

# Zsh Configs
for f in `ls $ZSHDIR/*`; do source $f; done
