# get rid of greeting
set fish_greeting
# vim mode
fish_vi_key_bindings
# aliases
#alias rm="trash-put"
alias grep='grep --color=auto'
alias ls='exa'
alias cat='bat'
alias ..='cd ..'
alias mv='mv -i'
alias fishtank='asciiquarium'
alias glo='git log --oneline'
alias gs='onefetch;git status'
alias wifis='nmcli device wifi'
alias hibernate='systemctl hibernate'
function vima
    vim $argv ./*
end
# export default editor and terminal
set -x EDITOR vim
set -x VISUAL vim
# use starship prompt
starship init fish | source
