#!/bin/bash

if [[ -f $HOME/.dotfiles/.sshrc.link ]];then source $HOME/.dotfiles/.sshrc.link; else echo "Cannot find ~/.dotfiles/.sshrc, change dotfiles path"; fi

if [ ! -d "$DOTORIG" ]; then mkdir $DOTORIG; fi

symlinktail="link"

function linkify {
    echo "$1" | sed "s/^$DOTDIRNAME\///g" | sed "s/\.$symlinktail$//g"
}
(cd $HOME && \
    for i in `find $DOTDIRNAME -name "*.$symlinktail"`; do
        if [[ -a "`linkify $i`" ]]; then mv "`linkify $i`" $DOTORIG/; fi;
        if [[ -h "`linkify $i`" ]]; then rm "`linkify $i`"; fi;
        ln -s $i `linkify $i`
    done \
)

exit 0
