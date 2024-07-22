return {
  "nvimdev/lspsaga.nvim",

  event = "LspAttach",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter", -- optional
    "nvim-tree/nvim-web-devicons",     -- optional
  },
  config = function()
    require("lspsaga").setup({
      ui = {
        kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
      },
      callhierarchy = {
        layout = "float",
      },
    })
  end,
}
