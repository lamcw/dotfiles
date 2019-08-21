function () {

  # geometry configuration
  GEOMETRY_STATUS_SYMBOL_COLOR_HASH=true

  GEOMETRY_RPROMPT+=(geometry_virtualenv geometry_exec_time geometry_jobs geometry_git)
  GEOMETRY_INFO=()

  zstyle :compinstall filename '$ZDOTDIR/.zshrc'
  zstyle ':completion:*' menu select
  zstyle ':completion:*' rehash true

  autoload -Uz compinit promptinit
  compinit
  promptinit

  setopt COMPLETE_ALIASES
  setopt EXTENDEDGLOB

  HISTFILE=$ZDOTDIR/.histfile
  HISTSIZE=2000
  SAVEHIST=$HISTSIZE
  setopt HIST_SAVE_NO_DUPS
  setopt HIST_IGNORE_ALL_DUPS
  setopt HIST_IGNORE_SPACE
  setopt SHARE_HISTORY

  # pip zsh completion start
  # not using eval for faster startup
  function _pip_completion {
    local words cword
    read -Ac words
    read -cn cword
    reply=( $( COMP_WORDS="$words[*]" \
      COMP_CWORD=$(( cword-1 )) \
      PIP_AUTO_COMPLETE=1 $words[1] ) )
  }
  compctl -K _pip_completion pip
  # pip zsh completion end
  # for pip3
  compctl -K _pip_completion pip3

  local plugins=(archlinux \
    colored-man-pages \
    common-aliases \
    fast-syntax-highlighting \
    git \
    geometry
  )

  # source all plugins
  foreach file ($plugins)
    if [[ -f $ZDOTDIR/plugins/$file/$file.plugin.zsh ]]; then
      source $ZDOTDIR/plugins/$file/$file.plugin.zsh
    fi
  end

  source $ZDOTDIR/aliases.zsh
  source $ZDOTDIR/keybindings.zsh

  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

  # fshow - git commit browser
  fshow() {
    git log --graph --color=always \
        --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
    fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
        --bind "ctrl-m:execute:
                  (grep -o '[a-f0-9]\{7\}' | head -1 |
                  xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                  {}
  FZF-EOF"
  }
}
