eval "$(/opt/homebrew/bin/brew shellenv)"

# added by Nix installer
if [ -e /Users/thomaslam/.nix-profile/etc/profile.d/nix.sh ]; then
  . /Users/thomaslam/.nix-profile/etc/profile.d/nix.sh
fi

typeset -U path

userlocalbin=$HOME/.local/bin
if [ -d $userlocalbin ]; then
  path=($path[@] $userlocalbin)
fi
