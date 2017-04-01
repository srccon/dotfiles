#!/bin/bash

# What utilites are needed?
NEEDED=(git vim ncdu ranger lynx htop tree zsh)
APTNEEDED=(ack-grep)
PACMANNEEDED=(ack)
YUMNEEDED=(ack)

# Are Dependencies set (double negativeTODO) 
depsunmet=0

# Empty array to be filled with needed utilites
NEEDTOINSTALL=()
APTNEEDTOINSTALL=()
PACMANNEEDTOINSTALL=()
YUMNEEDTOINSTALL=()

# Which package manager are possible
PKGMANAGERS=(apt yum pacman)

# Quickly check if a package is installed by returning path, if empty then it is not installed
function isinstalled() {
	whereis $1 | cut -s -f2 -d" "
}

# Switch to find Package manager install command
for pkgm in "${PKGMANAGERS[@]}"; do
	if [ -n "$(isinstalled $pkgm)" ]; then
		case $pkgm in
		apt)
			PKM="apt-get install -y"
			;;
		yum)
			PKM="yum install"
			;;
		pacman)
			PKM="pacman -Syu"
			;;
		*)
			;;
		esac
		# echo "Using $pkgm and $PKM to install packages"
	fi
done

# Find which needed apps are missing
for app in "${NEEDED[@]}"; do
	if [ -z "$(isinstalled $app)" ]; then
		NEEDTOINSTALL+=("$app")
	fi
done
for app in "${APTNEEDED[@]}"; do
	if [ -z "$(isinstalled $app)" ]; then
		APTNEEDTOINSTALL+=("$app")
	fi
done
for app in "${PACMANNEEDED[@]}"; do
	if [ -z "$(isinstalled $app)" ]; then
		PACMANNEEDTOINSTALL+=("$app")
	fi
done
for app in "${YUMNEEDED[@]}"; do
	if [ -z "$(isinstalled $app)" ]; then
		YUMNEEDTOINSTALL+=("$app")
	fi
done

# Install missing needed apps
if [ -n "${NEEDTOINSTALL[*]}" ]; then
	echo "Install Needed apps: ${NEEDTOINSTALL[*]} ${PACMANNEEDTOINSTALL[*]} ${APTNEEDTOINSTALL[*]} ${YUMNEEDTOINSTALL[*]} (y/n)"
	read installapps
	if [ $installapps = "y" ];then
		sudo $PKM ${NEEDTOINSTALL[@]}
                if [[ -x `which pacman` ]];then $PKM ${PACMANNEEDTOINSTALL[*]}; fi
                if [[ -x `which apt-get` ]];then $PKM ${APTNEEDTOINSTALL[*]}; fi
                if [[ -x `which yum` ]];then $PKM ${YUMNEEDTOINSTALL[*]}; fi
		depsunmet=0
	else
		echo "Skipping Needed Apps Install"
		depsunmet=1
	fi
fi


