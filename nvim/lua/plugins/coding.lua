return {
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp" },
    opts = {
      inlay_hints = {
        inline = false,
      },
      ast = {
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },
        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },
      },
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    ft = { "typescript", "typescriptreact", "javascriptreact", "javascript" },
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
    config = function()
      require("typescript-tools").setup {
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
        settings = {
          jsx_close_tag = {
            enable = true,
            filetypes = { "javascriptreact", "typescriptreact" },
          },
        },
      }
    end,
  },
  { import = "nvchad.blink.lazyspec" },
  {
    "Saghen/blink.cmp",
    dependencies = {
      "Kaiser-Yang/blink-cmp-avante",
    },
    opts = require "configs.blink",
  },
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },

      -- optional picker via telescope
      { "nvim-telescope/telescope.nvim" },
      -- optional picker via fzf-lua
      { "ibhagwan/fzf-lua" },
      -- .. or via snacks
      {
        "folke/snacks.nvim",
        opts = {
          terminal = {},
        },
      },
    },
    event = "LspAttach",
    opts = {
      backend = "delta",
    },
  },
}
