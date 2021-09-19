export DOTFILES=${DOTFILES:-$HOME/.dotfiles}
# override default zsh startup files directory
export ZDOTDIR=${ZDOTDIR:-$DOTFILES/zsh}

# preferred editor
export EDITOR=${EDITOR:-nvim}

export GPG_TTY=$(tty)
