# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets

# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
	function zle-line-init() {
		echoti smkx
	}
	function zle-line-finish() {
		echoti rmkx
	}
	zle -N zle-line-init
	zle -N zle-line-finish
fi

# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
	autoload -U up-line-or-beginning-search
	zle -N up-line-or-beginning-search
	bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
	autoload -U down-line-or-beginning-search
	zle -N down-line-or-beginning-search
	bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# vi-mode
bindkey -v

# kill the delay after hitting <ESC> and when mode change is registered
export KEYTIMEOUT=1

# vim-like key bindings
bindkey '^P' up-history
bindkey '^N' down-history

bindkey -a 'gg' beginning-of-buffer-or-history
bindkey -a 'g~' vi-oper-swap-case
bindkey -a G end-of-buffer-or-history

bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

# vim-style text objects
# from zshwiki.org/home/zle/vi-mode
#
# autoload -U select-bracketed select-quoted
# zle -N select-bracketed
# zle -N select-quoted
# for km in viopp visual; do
# 	bindkey -M $km -- '-' vi-up-line-or-history
# 	for c in {a,i}"${(s..):-\'\"\`\|,./:;-=+@}"; do
# 		bindkey -M $km $c select-quoted
# 	done
# 	for c in {a,i}${(s..):-'()[]{}<>bB'}; do
# 		bindkey -M $km $c select-bracketed
# 	done
# done
