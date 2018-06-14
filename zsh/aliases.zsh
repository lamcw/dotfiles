# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes.

# Basic utils
alias ls='ls --color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'

# Changing/making/removing directory
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

alias -g ..='cd ..'
alias -g ...='cd ../..'
alias -g ....='cd ../../..'
alias -g .....='cd ../../../..'
alias -g ......='cd ../../../../..'

# cd up to n dirs
# using:  cd.. 10 or cd.. dir
function cd_up() {
	case $1 in
		# if not a number
		*[!0-9]*)
			# search dir_name in current path, if found cd to it
			cd $( pwd | sed -r "s|(.*/$1[^/]*/).*|\1|" )
			;;
		*)
			# cd ../../../ (N dirs up)
			cd $(printf "%0.0s../" $(seq 1 $1));
			;;
	esac
}
alias 'cd..'='cd_up'

alias dev="cd $HOME/dev/"
alias dp1='xrandr --output eDP1 --auto --pos 0x1350 --output DP1	\
	   --scale 1.25x1.25 --auto --pos 0x0 --fb 2400x2430'
