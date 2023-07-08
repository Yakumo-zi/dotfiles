#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias grep='rg'
alias vim='nvim'
alias vi='nvim'
alias ps='procs'
alias cat='bat'
alias ls='exa'

PS1='[\u@\h \W]\$ '
export https_proxy=http://127.0.0.1:7890
export http_proxy=http://127.0.0.1:7890
export all_proxy=socks5://127.0.0.1:7890
eval "$(starship init bash)"
eval "$(zoxide init bash)"

EDITOR='nvim'
VISUAL='nvim'
. "$HOME/.cargo/env"

source /home/devil/.config/broot/launcher/bash/br
