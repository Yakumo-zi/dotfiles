#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'

PS1='[\u@\h \W]\$ '
export https_proxy=http://127.0.0.1:7890
export http_proxy=http://127.0.0.1:7890
export all_proxy=socks5://127.0.0.1:7890
eval "$(starship init bash)"
eval "$(zoxide init bash)"

EDITOR='nvim'
VISUAL='nvim'
. "$HOME/.cargo/env"
