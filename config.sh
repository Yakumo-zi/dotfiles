ln -s "$(pwd)/nvim" "${HOME}/.config/"
ln -s "$(pwd)/yazi" "${HOME}/.config/"
ln -s "$(pwd)/tmux.conf" "${HOME}/.tmux.conf"
ln -s "$(pwd)/.bashrc" "${HOME}/.bashrc"
ln -s "$(pwd)/.bash_profile" "${HOME}/.bash_profile"

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
