# geometry configuration
GEOMETRY_STATUS_SYMBOL_COLOR_HASH=true

GEOMETRY_RPROMPT+=(geometry_virtualenv geometry_exec_time geometry_jobs geometry_git)
GEOMETRY_INFO=()

zstyle :compinstall filename '$ZDOTDIR/.zshrc'
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true

fpath+=$ZDOTDIR/functions
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

foreach file ($ZDOTDIR/rc/*.zsh)
  source $file
end

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
