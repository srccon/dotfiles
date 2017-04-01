#!/bin/bash

function submoduleInstall {
    git submodule init
    git submodule update --recursive --remote
}

function dotfilesSync {
    $DOTDIR/sync.sh
}

# Check for Dotfiles, install and update
if [ ! $depsunmet = 1 ];then
    if [ ! -d "$DOTDIR" ]; then
        echo "Install dotfiles: (y/n)"
        read installdotfiles
        if [ $installdotfiles = "y" ];then
            git clone $DOTREPO $DOTDIR
            (cd $DOTDIR && \
                submoduleInstall && \
                dotfilesSync \
            )
        fi
    else
        echo "Update dotfiles: (y/n)"
        read updatedotfiles
        if [ $updatedotfiles = "y" ];then
            (cd $DOTDIR && \
                git pull && \
                submoduleInstall && \
                dotfilesSync \
            )
        fi
    fi
fi
