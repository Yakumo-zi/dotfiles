local env = require("env")

return {
  {
    "neovim/nvim-lspconfig",
    config = function() require("configs.lspconfig") end,
  },
  {
    "hrsh7th/nvim-cmp",
    enabled = false,
  },
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = { "InsertEnter", "CmdLineEnter" },
    dependencies = {
      "rafamadriz/friendly-snippets",
      {
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require("nvchad.configs.luasnip")
        end,
      },
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
      },
    },
    opts_extend = { "sources.default" },
    opts = function()
      local opts = require("nvchad.blink.config")
      opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      })

      return opts
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
    opts = function() return require("configs.fidget") end,
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
  {
    "mrcjkb/rustaceanvim",
    enabled = env.executable("rust-analyzer"),
    version = "^6",
    lazy = false,
    init = function()
      vim.g.rustaceanvim = {
        server = {
          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                buildScripts = {
                  enable = false,
                },
              },
              checkOnSave = false,
              diagnostics = {
                disabled = { "unresolved-proc-macro" },
              },
              procMacro = {
                enable = false,
              },
            },
          },
        },
      }
    end,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    lazy = false,
    priority = 1000,
    keys = {
      {
        "<leader>dd",
        function() vim.diagnostic.open_float({ border = "rounded" }) end,
        desc = "Line diagnostics",
      },
      {
        "<leader>dt",
        "<cmd>TinyInlineDiag toggle<CR>",
        desc = "Toggle inline diagnostics",
      },
    },
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "classic",
        options = {
          overwrite_events = { "LspAttach", "DiagnosticChanged", "BufEnter" },
          show_source = {
            enabled = true,
          },
          add_messages = {
            display_count = true,
          },
          enable_on_insert = true,
          multilines = {
            enabled = true,
            always_show = true,
          },
        },
      })
    end,
  },
}
