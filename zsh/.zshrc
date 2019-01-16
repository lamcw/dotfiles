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
foreach file ($plugins)
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

transfer() { 
	# check arguments
	if [ $# -eq 0 ]; 
	then 
		echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"
		return 1
	fi

	# get temporarily filename, output is written to this file show progress can be showed
	tmpfile=$(mktemp -t transferXXX)

	# upload stdin or file
	file=$1

	if tty -s; 
	then 
		basefile=$(basename "$file" | sed -e 's/[^a-zA-Z0-9._-]/-/g') 

		if [ ! -e $file ];
		then
			echo "File $file doesn't exists."
			return 1
		fi

		if [ -d $file ];
		then
			# tar and gzip directory and transfer
			tarfile=$(mktemp -t transferXXX.zip)
			tar -czf $tarfile $file
			curl --progress-bar --upload-file "$tarfile" "https://transfer.sh/$basefile.tar.gz" >> $tmpfile
			rm -f $tarfile
		else
			# transfer file
			curl --progress-bar --upload-file "$file" "https://transfer.sh/$basefile" >> $tmpfile
		fi
	else 
		# transfer pipe
		curl --progress-bar --upload-file "-" "https://transfer.sh/$file" >> $tmpfile
	fi

	# cat output link
	cat $tmpfile

	# cleanup
	rm -f $tmpfile
}

}
