export DOTFILES=$HOME/.dotfiles
# override default zsh startup files directory
export ZDOTDIR=$DOTFILES/zsh

# export GDK_BACKEND=wayland
# export CLUTTER_BACKEND=wayland

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR=~callumh/nvim
else
  export EDITOR='nvim'
fi

# fix blank window in Java application
export _JAVA_AWT_WM_NONREPARENTING=1

export GPG_TTY=$(tty)
