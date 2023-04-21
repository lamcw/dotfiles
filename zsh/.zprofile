typeset -U path

userlocalbin=$HOME/.local/bin
if [ -d $userlocalbin ]; then
  path=($path[@] $userlocalbin)
fi

# Nix
path=($path[@] /nix/var/nix/profiles/default/bin /usr/local/go/bin)

if command -v go 2> /dev/null; then
  # Add $GOPATH/bin to path
  path=($path[@] $(go env GOPATH)/bin)
fi

# Do not start ssh-agent on remote since it will override the forwarded agent from SSH
# eval "$(ssh-agent -s)" > /dev/null

# add direnv
eval "$(direnv hook $SHELL)"

# add cargo
# . "$HOME/.cargo/env"
