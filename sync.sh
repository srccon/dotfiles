#!/bin/bash

# Where do you want the dotfiles directory?
dotfilepwd="$HOME/.dotfiles"

# How about the original/default dotfiles?
dotfileorig="$dotfilepwd/orig"

# Temp location
tmpfile="/tmp/dotfiles.tmp"

function finish() {
    rm $tmpfile
}
trap finish EXIT

if [ ! -d "$dotfileorig" ]; then
	echo "Making $dotfileorig directory for existing files/directories"
	mkdir $dotfileorig
fi

find -maxdepth 1 | sed 's/\.\///' | tail -n +2 | grep -v ^sync.sh$ | grep -v ^orig$ | grep -v .md$ | grep -v ^.git | grep -v ^lib$ | grep -v .swp$ > "$tmpfile"

while read i; do
	if [ -a "$HOME/$i" -a ! -h "$HOME/$i" ]; then
		echo "Moving $i to $dotfileorig/$i"
		mv "$HOME/$i" "$dotfileorig/"
	fi
	if [ -h "$HOME/$i" ]; then
		rm "$HOME/$i"
	fi
        (cd $HOME && ln -s ".dotfiles/$i" "$i")
done < "$tmpfile"

exit 0
