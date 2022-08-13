# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes.

# Basic utils
alias ls='ls --color=auto -h'
alias grep='grep --color=auto'

# Changing/making/removing directory
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

alias -g ..='cd ..'
alias -g ...='cd ../..'
alias -g ....='cd ../../..'
alias -g .....='cd ../../../..'
alias -g ......='cd ../../../../..'

alias dev="cd $HOME/work/"

alias ibrew='arch -x86_64 /usr/local/bin/brew'

# M1 stuff
alias native="CANVA_NIXPKGS_SYSTEM=aarch64-darwin"
