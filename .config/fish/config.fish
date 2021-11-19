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
alias wifis='nmcli device wifi'
# export default editor and terminal
set -x EDITOR vim
set -x VISUAL vim
set -x TERM xterm
set -x TERMINAL xterm
# use starship prompt
#starship init fish | source