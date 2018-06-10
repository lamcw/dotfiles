# configure path
typeset -U path
path=($(ruby -e 'print Gem.user_dir')/bin $path[@])

# launch sway
if [[ -x "$(command -v sway)" ]] && [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	exec sway
fi
