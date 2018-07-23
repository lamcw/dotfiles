function () {

# geometry configuration
PROMPT_GEOMETRY_RPROMPT_ASYNC=true
PROMPT_GEOMETRY_GIT_CONFLICTS=true
PROMPT_GEOMETRY_COLORIZE_SYMBOL=true
PROMPT_GEOMETRY_COLORIZE_ROOT=true
PROMPT_GEOMETRY_EXEC_TIME=true

GEOMETRY_PROMPT_PLUGINS=(virtualenv exec_time jobs git hg)

zstyle :compinstall filename '$ZDOTDIR/.zshrc'
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true

autoload -Uz compinit promptinit
compinit
promptinit

setopt COMPLETE_ALIASES

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
	git
)

# source all plugins
foreach file (`echo $plugins`)
	if [[ -f $ZDOTDIR/plugins/$file/$file.plugin.zsh ]]; then
		source $ZDOTDIR/plugins/$file/$file.plugin.zsh
	fi
end

source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/keybindings.zsh
source $ZDOTDIR/plugins/geometry/geometry.zsh

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export GTK_IM_MODULE=ibus

# Useful fzf functions
# fd - cd to selected directory
fd() {
	local dir
	dir=$(find ${1:-.} -path '*/\.*' -prune \
		-o -type d -print 2> /dev/null | fzf +m) &&
		cd "$dir"
}

# fda - including hidden directories
fda() {
	local dir
	dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

}
