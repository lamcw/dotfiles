# added by Nix installer
if [ -e /Users/thomaslam/.nix-profile/etc/profile.d/nix.sh ]; then
  . /Users/thomaslam/.nix-profile/etc/profile.d/nix.sh
fi

typeset -U path

userlocalbin=$HOME/.local/bin
if [ -d $userlocalbin ]; then
  path=($path[@] $userlocalbin)
fi

# Use brew with M1 (arm)
eval "$(/opt/homebrew/bin/brew shellenv)"

# Use brew with rosetta
# eval "$(/usr/local/bin/brew shellenv)"
#
# Add $GOPATH/bin to path
path=($path[@] $(go env GOPATH)/bin)

# Add unversioned symlinks `python`, `python-config`, `pip` etc. pointing to
# `python3`, `python3-config`, `pip3` etc.,
path=($path[@] /opt/homebrew/opt/python@3.9/libexec/bin)

eval "$(ssh-agent -s)" > /dev/null

# add direnv
eval "$(direnv hook $SHELL)"
