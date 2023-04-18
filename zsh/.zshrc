# geometry configuration
GEOMETRY_STATUS_SYMBOL_COLOR_HASH=true

# Not adding geometry_git as it is too slow on monorepo
GEOMETRY_RPROMPT+=(geometry_virtualenv geometry_exec_time geometry_jobs)
GEOMETRY_INFO=()

zstyle :compinstall filename '$ZDOTDIR/.zshrc'
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true

fpath+=$ZDOTDIR/functions
autoload $ZDOTDIR/functions/*
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
  git \
  geometry
)

# source all plugins
foreach file ($plugins)
  if [[ -f $ZDOTDIR/plugins/$file/$file.plugin.zsh ]]; then
    source $ZDOTDIR/plugins/$file/$file.plugin.zsh
  fi
end

source $ZDOTDIR/plugins/fast-syntax-highlighting/F-Sy-H.plugin.zsh

foreach file ($ZDOTDIR/rc/*.zsh)
  source $file
end

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

# neovim as man pager
export MANPAGER='nvim +Man!'
export MANWIDTH=999

#compdef gt
###-begin-gt-completions-###
#
# yargs command completion script
#
# Installation: /opt/homebrew/bin/gt completion >> ~/.zshrc
#    or /opt/homebrew/bin/gt completion >> ~/.zprofile on OSX.
#
_gt_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" /opt/homebrew/bin/gt --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _gt_yargs_completions gt
###-end-gt-completions-###
