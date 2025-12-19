return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "saghen/blink.cmp",
      "folke/lazydev.nvim",
      "j-hui/fidget.nvim",
    },
    config = function()
      -- LSP is now started in after/ftplugin/<filetype>.lua
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = function() return require("plugins.configs.fidget") end,
  },
  {
    "Wansmer/symbol-usage.nvim",
    event = "LspAttach",
    opts = {
      text_format = function(symbol)
        local res = {}
        if symbol.references then
          local usage = symbol.references == 1 and "reference" or "references"
          table.insert(
            res,
            { ("󰌹  %s %s"):format(symbol.references, usage), "LspCodeLens" }
          )
        end
        return res
      end,
    },
  },
}
