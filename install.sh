nix-channel --update
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
  'starship'
  'fish'
  'atuin'
)

install_pkgs=""
for i in "${!Pkgs[@]}"; do
	Pkgs[i]="nixpkgs.${Pkgs[$i]}"
	install_pkgs=${install_pkgs}" "${Pkgs[$i]}
done
# echo "nix-env -iA ${install_pkgs}"

eval "nix-env -iA ${install_pkgs}"
