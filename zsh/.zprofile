# configure path
typeset -U path

which ruby > /dev/null && path=($(ruby -e 'print Gem.user_dir')/bin $path[@])

if [ -d "$HOME/bin" ]; then
	path=($HOME/bin $path[@])
fi

# launch sway
if [[ -x "$(command -v sway)" ]] && [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	exec sway
fi
