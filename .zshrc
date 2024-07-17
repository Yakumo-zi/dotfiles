
eval "$(starship init zsh)"
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH
. "$HOME/.cargo/env"

eval "$(vfox activate bash)"
eval "$(zoxide init bash)"

alias ls='exa'
alias cat='bat'
alias cd='z'
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
eval "$(atuin init zsh)"


