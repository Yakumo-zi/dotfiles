#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

ulimit -n 10240

alias grep='rg'
alias vim='nvim'
alias vi='nvim'
alias ps='procs'
alias cat='bat'
alias ls='exa'
alias ll="ls -l --tree -h"
alias cd='z'
alias proxy="source ~/utils/proxy.sh"

PS1='[\u@\h \W]\$ '

# export env
# export https_proxy=http://192.168.60.163:7890
# export http_proxy=http://192.168.60.163:7890
# export all_proxy=socks5://192.168.60.163:7890
# export PATH="/home/devil/tools/squashfs-root/usr/bin:$PATH"
# export PATH="/home/devil/code/script:$PATH"

eval "$(starship init bash)"
eval "$(zoxide init bash)"

EDITOR='nvim'
VISUAL='nvim'
. "$HOME/.cargo/env"

# source /home/devil/.config/broot/launcher/bash/br
source /usr/share/nvm/init-nvm.sh
# source ~/code/python/venv/bin/activate

# export LIBVA_DRIVER_NAME=nvidia
# export XDG_SESSION_TYPE=wayland
# export GBM_BACKEND=nvidia-drm
# export __GLX_VENDOR_LIBRARY_NAME=nvidia
# export WLR_NO_HARDWARE_CURSORS=1
