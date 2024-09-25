# sudo rm -rf /nix
# mv ~/.profile ~/.profile.backup-"${USER}"
# touch ~/.profile
# sh <(curl -L https://nixos.org/nix/install)
#
# if [ -e /home/yakumo/.nix-profile/etc/profile.d/nix.sh ]; then eval '. /home/yakumo/.nix-profile/etc/profile.d/nix.sh'; fi # added by Nix installer
# sudo chown -R "${USER}" /nix
# nix-channel --update

Pkgs=(
  'fastfetch'
  'neovim'
	'git'
	'curl'
	'unzip'
	'fzf'
	'ripgrep'
	'lazygit'
	'gcc14'
	'go'
	'nodejs_20'
	'pnpm'
	'rustup'
	'cmake'
	'gnumake'
	'docker_27'
	'clang-tools'
	'lua-language-server'
	'stylua'
	'gopls'
	'nixd'
	'nodePackages_latest.bash-language-server'
  'gh'
  'yazi'
  'tmux'
)

install_pkgs=""
for i in "${!Pkgs[@]}"; do
	Pkgs[i]="nixpkgs.${Pkgs[$i]}"
	install_pkgs=${install_pkgs}" "${Pkgs[$i]}
done
# echo "nix-env -iA ${install_pkgs}"

eval "nix-env -iA ${install_pkgs}"

ln -s "$(pwd)/nvim" "${HOME}/.config/nvim"
ln -s "$(pwd)/yazi" "${HOME}/.config/yazi"
ln -s "$(pwd)/tmux.conf" "${HOME}/.tmux.conf"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
