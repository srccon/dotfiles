#!/bin/bash

source ./vars

function finish() {
    rm $DOTTMP
}
trap finish EXIT

if [ ! -d "$DOTORIG" ]; then
	echo "Making $DOTORIG directory for existing files/directories"
	mkdir $DOTORIG
fi

find -maxdepth 1 | sed 's/\.\///' | tail -n +2 | grep -v ^sync.sh$ | grep -v ^orig$ | grep -v .md$ | grep -v ^.git | grep -v ^lib$ | grep -v .swp$ > "$DOTTMP"

while read i; do
	if [ -a "$HOME/$i" -a ! -h "$HOME/$i" ]; then
		echo "Moving $i to $DOTORIG/$i"
		mv "$HOME/$i" "$DOTORIG/"
	fi
	if [ -h "$HOME/$i" ]; then
		rm "$HOME/$i"
	fi
        (cd $HOME && ln -s "$DOTDIRNAME/$i" "$i")
done < "$DOTTMP"

exit 0
