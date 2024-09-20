# dotfiles

## nvim

### Requirements software for this repository

- neovim 0.10.0+
- node.js 20.0.0+
- python 3.10.0 +
- zsh(optional)
- zxoide
- vfox
- exa
- atuin
- starship
- make
- ripgrep
- yazi (terminal file manager)
- fzf (fuzzy finder)

### Other useful software

- bat (cat like tool,write in rust)
- bottom (system monitor)
- dust (du tool,write in rust)
- lazygit (git gui)
- zellij (terminal multiplexer)
- glow (markdown preview)
- tmux (terminal multiplexer)


### 解决在Nix环境下C/C++ 标准头文件使用clangd无法找到的情况

1. 使用Home Manager安装clang-tools
2. 使用Mason安装clangd（或许不需要这一步，未验证）
3. 将clangd链接到`~/.local/share/nvim/mason/bin`目录下
