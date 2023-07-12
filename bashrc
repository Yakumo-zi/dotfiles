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
export PATH="/home/devil/tools/squashfs-root/usr/bin:$PATH"
eval "$(starship init bash)"
eval "$(zoxide init bash)"

EDITOR='nvim'
VISUAL='nvim'
. "$HOME/.cargo/env"

source /home/devil/.config/broot/launcher/bash/br
source /usr/share/nvm/init-nvm.sh

export LIBVA_DRIVER_NAME=nvidia
export XDG_SESSION_TYPE=wayland
export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export WLR_NO_HARDWARE_CURSORS=1

eval "$(register-python-argcomplete pipx)"
