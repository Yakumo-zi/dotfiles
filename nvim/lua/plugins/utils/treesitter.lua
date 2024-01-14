return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local opts = {
      ensure_installed = { "c", "lua", "cpp", "python", "rust", "bash", "vimdoc", "markdown", "go", "markdown_inline" },
      auto_install = true,
    }
    require('nvim-treesitter.configs').setup(opts)
  end,
}
