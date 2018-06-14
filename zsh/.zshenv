export DOTFILES=$HOME/.dotfiles
# override default zsh startup files directory
export ZDOTDIR=$DOTFILES/zsh

export LANG="en_US.utf8"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR=~callumh/nvim
else
  export EDITOR='nvim'
fi

export GPG_TTY=$(tty)
