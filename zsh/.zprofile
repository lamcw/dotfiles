# configure path
typeset -U path

which ruby > /dev/null && path=($path[@] $(ruby -e 'print Gem.user_dir')/bin)
export GEM_HOME=$HOME/.gem

if [ -d "$HOME/bin" ]; then
	path=($path[@] $HOME/bin)
fi

# launch sway
if [[ -x "$(command -v sway)" ]] && [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	exec sway
fi
