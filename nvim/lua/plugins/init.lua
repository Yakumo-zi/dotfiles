return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, conf)
      local options = require('configs.nvim-cmp')
      return vim.tbl_deep_extend('force', conf, options)
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "vimdoc",
        "html",
        "css",
        "go",
        "rust",
        "c",
        "cpp",
      },
    },
  }
}
