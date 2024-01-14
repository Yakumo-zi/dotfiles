return {
  "folke/neodev.nvim",
  "RRethy/vim-illuminate",
  "simrat39/rust-tools.nvim",
  {
    "j-hui/fidget.nvim",
    branch = "legacy",
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    init = function()

    end,
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    opts = {
      ensure_installed = {
        "lua_ls",
        "clangd",
      },
      automatic_installation = true,
    },
    config = function()
      -- Neodev setup before LSP config
      require("neodev").setup()
      require("mason").setup()
      require("mason-lspconfig").setup()


      -- Turn on LSP status information
      require("fidget").setup()
      -- LSP appearance config
      vim.diagnostic.config({ virtual_text = false }, nil)

      -- LSP config
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local server_configs = require("plugins.lsp.configs.server_configs")
      local keymaps = require("plugins.lsp.configs.keymaps")

      local lsp_autoconfig = {
        function(server_name)
          require("lspconfig")[server_name].setup({
            on_attach = function(client, bufnr)
              keymaps.on_attach(client, bufnr)
              require("lsp_signature").on_attach({
                bind = true,
                handler_opts = {
                  border = "rounded"
                }
              }, bufnr)
            end,
            capabilities = capabilities,

          })
        end,
      }
      for server, setup in ipairs(server_configs) do
        lsp_autoconfig[server] = setup
      end
      require("mason-lspconfig").setup_handlers(
        lsp_autoconfig
      )
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts) require 'lsp_signature'.setup(opts) end
  }

}
