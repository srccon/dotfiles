#!/bin/bash

# Where do you want the dotfiles directory?
dotfilepwd="$HOME/.dotfiles"

# How about the original/default dotfiles?
dotfileorig="$dotfilepwd/orig"

# Temp location
tmpfile="/tmp/dotfiles.tmp"

if [ ! -d "$dotfileorig" ]; then
	echo "Making $dotfileorig directory for existing files/directories"
	mkdir $dotfileorig
fi

find -maxdepth 1 | sed 's/\.\///' | tail -n +2 | grep -v ^sync.sh$ | grep -v ^orig$ | grep -v ^.git | grep -v ^lib$ > "$tmpfile"

while read i; do
	if [ -a "$HOME/$i" -a ! -h "$HOME/$i" ]; then
		echo "Moving $i to $dotfileorig/$i"
		mv "$HOME/$i" "$dotfileorig/"
	fi
	if [ -h "$HOME/$i" ]; then
		echo "Updating Symlink $i"
		rm "$HOME/$i"
	fi
	ln -s "$dotfilepwd/$i" "$HOME/$i"
done < "$tmpfile"

rm $tmpfile

exit 0
