#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ "`echo $0`" == "bash" ]];then 
	# append to the history file, don't overwrite it
	shopt -s histappend

	# check the window size after each command and, if necessary,
	# update the values of LINES and COLUMNS.
	shopt -s checkwinsize

	# enable programmable completion features (you don't need to enable
	# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
	# sources /etc/bash.bashrc).
	if ! shopt -oq posix; then
		if [ -f /usr/share/bash-completion/bash_completion ]; then
	    		. /usr/share/bash-completion/bash_completion
	  	elif [ -f /etc/bash_completion ]; then
	    	. /etc/bash_completion
	  	fi
	fi

	# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
	HISTSIZE=1000
	HISTFILESIZE=2000
fi


# What utilites are needed?
NEEDED=(git vim ncdu ranger lynx htop tree)
#TODO add ack / ack-grep

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
	(cd ~/.dotfiles && git submodule update && ./sync.sh)
else
	(cd ~/.dotfiles && git pull && git submodule update && ./sync.sh )
fi

# Source apps to shell
source ~/.dotfiles/lib/liquidprompt/liquidprompt
source ~/.dotfiles/lib/z/z.sh

# MOTD
# Nice greeting when opening a terminal window
#for f "$HOME/.motd.d/*"; do source $f; echo $f; done
for f in `ls $HOME/.motd.d/*`; do source $f; done

# Aliases
# Making commands a little shorter
for f in `ls $HOME/.bash_aliases.d/*`; do source $f; done

PS1='[\u@\h \W]\$ '
