return {
  {
    "simrat39/rust-tools.nvim",
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "folke/neodev.nvim",
      "RRethy/vim-illuminate",
      "hrsh7th/cmp-nvim-lsp",
      "lvimuser/lsp-inlayhints.nvim",
      {
      "j-hui/fidget.nvim",
        branch="legacy"
      }
    },
    config = function()
      -- Set up Mason before anything else
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
        },
        automatic_installation = true,
      })

      -- Quick access via keymap
      require("helpers.keys").map("n", "<leader>M", "<cmd>Mason<cr>", "Show Mason")

      -- Neodev setup before LSP config
      require("neodev").setup()

      -- Turn on LSP status information
      require("fidget").setup()

      -- Set up cool signs for diagnostics
      local signs = { Error = " ", Warn = " ", Hint = "", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- Diagnostic config
      local config = {
        virtual_text = true,
        signs = {
          active = signs,
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
          focusable = true,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      }
      vim.diagnostic.config(config)
      -- This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(client, bufnr)
        local lsp_map = require("helpers.keys").lsp_map
        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
          vim.lsp.buf.format()
        end, { desc = "Format current buffer with LSP" })

        lsp_map("<leader>ff", "<cmd>Format<cr>", bufnr, "Format")

        -- Attach and configure vim-illuminate
        require("lsp-inlayhints").on_attach(client, bufnr)
        require("illuminate").on_attach(client)
      end

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
      local lsp = require("lspconfig")
      local lspconfig = {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      -- Lua
      require("plugins.lsp.lua").setup(lspconfig, lsp)
      require("plugins.lsp.rust").rust_setup(lspconfig, lsp)
      require("plugins.lsp.rust").rust_tool_setup()
      require("plugins.lsp.c_cpp").setup(lspconfig, lsp)
      require("plugins.lsp.front_end").setup(lspconfig, lsp)
      require("plugins.lsp.python").setup(lspconfig, lsp)
      require("plugins.lsp.default_lsp").setup(lspconfig, lsp)
    end,
  },
}
