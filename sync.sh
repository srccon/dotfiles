#!/bin/bash

# Where do you want the dotfiles directory
dotfilepwd="$HOME/.dotfiles"

dotfilebak="$dotfilepwd/orig"

syncfile="sync.sh"

# Temp location
tmpfile="/tmp/dotfiles.tmp"

if [ ! -d $dotfilebak ]; then
	echo "Making $dotfilebak directory for existing files/directories"
	mkdir $dotfilebak
fi

find -maxdepth 1 | sed 's/\.\///' | tail -n +2 | grep -v ^$syncfile | grep -v orig > "$tmpfile"

while read i; do
	if [ -a "$HOME/$i" -a ! -h "$HOME/$i" ]; then
		echo "Moving $i to $dotfilebak/$i"
		mv "$HOME/$i" "$dotfilebak/$i"
	fi
	if [ -h "$HOME/$i" ]; then
		echo "Updating Symlink $i"
		rm "$HOME/$i"
	fi
	ln -s "$dotfilepwd/$i" "$HOME/$i"
done < "$tmpfile"

rm $tmpfile

exit 0
