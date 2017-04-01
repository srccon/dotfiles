#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# What utilites are needed?
NEEDED=(git vim ncdu ranger lynx)

# Empty array to be filled with needed utilites
NEEDTOINSTALL=()

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

# Install missing needed apps
if [ -n "${NEEDTOINSTALL[*]}" ]; then
	echo "Install Needed apps: ${NEEDTOINSTALL[*]} (y/n)"
	read installapps
	if [ $installapps = "y" ];then
		sudo $PKM ${NEEDTOINSTALL[@]}
	else
		echo "Skipping Needed Apps Install"
	fi
fi

# Check for Dotfiles, install and update
if [ ! -d ~/.dotfiles ]; then
	git clone https://github.com/srccon/dotfiles.git .dotfiles
	(cd ~/.dotfiles && git submodule update)
else
	(cd ~/.dotfiles && git pull && git submodule update)
fi

# Source apps to shell
source ~/.dotfiles/lib/liquidprompt/liquidprompt
source ~/.dotfiles/lib/z/z.sh

alias ls='ls -a --color=auto'

PS1='[\u@\h \W]\$ '
