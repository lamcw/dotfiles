# configure path
typeset -U path

which ruby > /dev/null && path=($path[@] $(ruby -e 'print Gem.user_dir')/bin)
export GEM_HOME=$HOME/.gem

userlocalbin=$(systemd-path user-binaries)
if [ -d $userlocalbin ]; then
  path=($path[@] $userlocalbin)
fi

# launch sway
if [[ -x "$(command -v sway)" ]] && [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  export _JAVA_AWT_WM_NONREPARENTING=1
  exec sway
fi
