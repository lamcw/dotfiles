typeset -U path

userlocalbin=$HOME/.local/bin
if [ -d $userlocalbin ]; then
  path=($path[@] $userlocalbin)
fi

# Nix
path=($path[@] /nix/var/nix/profiles/default/bin)

# Add $GOPATH/bin to path
# path=($path[@] $(go env GOPATH)/bin)

# Add unversioned symlinks `python`, `python-config`, `pip` etc. pointing to
# `python3`, `python3-config`, `pip3` etc.,

eval "$(ssh-agent -s)" > /dev/null

# add direnv
eval "$(direnv hook $SHELL)"

# add cargo
# . "$HOME/.cargo/env"
