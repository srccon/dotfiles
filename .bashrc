#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Bash only stuff that zsh will skip
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

# Check for Dotfiles, install and update
if [ ! $depsunmet = 1 ];then
	if [ ! -d ~/.dotfiles ]; then
		echo "Install dotfiles: (y/n)"
		read installdotfiles
		if [ $installdotfiles = "y" ];then
			git clone https://github.com/srccon/dotfiles.git .dotfiles
			(cd ~/.dotfiles && \
				git submodule init && \
				git submodule update --recursive --remote && \
				./sync.sh \
			)
		fi
	else
		echo "Update dotfiles: (y/n)"
		read updatedotfiles
		if [ $updatedotfiles = "y" ];then
			(cd ~/.dotfiles && \
				git pull && \
				git submodule init && \
				git submodule update --recursive --remote && \
				./sync.sh \
			)
		fi
	fi
	
	# Source apps to shell
	source ~/.dotfiles/lib/z/z.sh

        # Add check for vim files
        if [[ ! -d $HOME/.vim/files ]];then mkdir -p $HOME/.vim/files/undo; mkdir -p $HOME/.vim/files/backup; mkdir -p $HOME/.vim/files/info; mkdir -p $HOME/.vim/files/swap; fi 

	
	# MOTD
	# Nice greeting when opening a terminal window
	#for f in `ls $HOME/.motd.d/*`; do source $f; done
	
	# Aliases
	# Making commands a little shorter
	for f in `ls $HOME/.bash_aliases.d/*`; do source $f; done
        
        if [[ "`echo $0`" == "bash" ]];then 
            source ~/.dotfiles/lib/liquidprompt/liquidprompt
        fi
fi

PS1='[\u@\h \W]\$ '
