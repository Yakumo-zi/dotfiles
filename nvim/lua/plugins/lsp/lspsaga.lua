return {
  'nvimdev/lspsaga.nvim',
  dependencies = {
    "neovim/nvim-lspconfig",
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons',     -- optional
  },
  config = function()
    require('lspsaga').setup({
      callhierarchy = {
        layout = 'float'
      },
      diagnostic = {
        diagnostic_only_current = true
      }
    })
  end,
}
