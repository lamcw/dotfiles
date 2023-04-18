export DOTFILES=${DOTFILES:-$HOME/.dotfiles}
# override default zsh startup files directory
export ZDOTDIR=${ZDOTDIR:-$DOTFILES/zsh}

# preferred editor
export EDITOR=${EDITOR:-nvim}

export GPG_TTY=$(tty)
if [ -e /Users/thomaslam/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/thomaslam/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# add cargo
. "$HOME/.cargo/env"
