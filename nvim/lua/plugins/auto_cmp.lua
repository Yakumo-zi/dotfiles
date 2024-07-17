-- 代码补全插件
-- 必须将依赖插件放到外部安装，否则会出现module not found
return {
  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = true,
  },
  {

    "hrsh7th/cmp-buffer",
    lazy = true,
  },
  {

    "hrsh7th/cmp-path",
    lazy = true,
  },
  {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "v2.*",
    build = "make install_jsregexp",
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dnpendencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local lspkind = require("lspkind")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      cmp.setup({
        enabled = true,
        -- set the completion window border
        window = {
          completion = { border = "rounded", winhighlight = "NormalFloat:NormalFloat,FloatBorder:NormalFloat" },
          documentation = { border = "rounded", winhighlight = "NormalFloat:NormalFloat,FloatBorder:NormalFloat" },
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
        }, {
          { name = "path" },
          { name = "buffer" },
          { name = "luasnip" },
        }),
        mapping = require("plugins.lsp.configs.keymaps").auto_cmp(cmp, luasnip),
        formatting = {
          expandable_indicator = true,
          fields = { "abbr", "kind", "menu" },

          format = function(entry, vim_item)
            lspkind.cmp_format({
              mode = "symbol_text",     -- show only symbol annotations
              maxwidth = 50,            -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
              ellipsis_char = "...",    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
              show_labelDetails = true, -- show labelDetails in menu. Disabled by default
            })(entry, vim_item)
            return vim_item
          end,
        },
      })
      vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'NONE', fg = '#D4D4D4' })
      vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#5f87af', fg = 'NONE' })
      vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'NONE', fg = '#5f87af' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })
    end,
  },
}
