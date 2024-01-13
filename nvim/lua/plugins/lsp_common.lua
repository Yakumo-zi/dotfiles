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
      require("mason").setup()
      require("mason-lspconfig").setup()

      -- Neodev setup before LSP config
      require("neodev").setup()

      -- Turn on LSP status information
      require("fidget").setup()

      -- LSP config
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local server_configs = require("plugins.lsp_config.server_configs")
      local keymaps = require("plugins.lsp_config.keymaps")

      local lsp_autoconfig = {
        function(server_name)
          require("lspconfig")[server_name].setup({
            on_attach = keymaps.on_attach,
            capabilities = capabilities

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
}
