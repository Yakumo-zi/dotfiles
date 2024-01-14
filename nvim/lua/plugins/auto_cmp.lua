-- 代码补全插件
-- 必须将依赖插件放到外部安装，否则会出现module not found
return {
  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = true,
  },
  {

    "hrsh7th/cmp-buffer",
    lazy = true
  },
  {

    "hrsh7th/cmp-path",
    lazy = true
  },
  {
    "L3MON4D3/LuaSnip",
    lazy = true
  },
  {
    "hrsh7th/nvim-cmp",
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
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
      cmp.setup({
        enabled = true,
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
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        },
      })
    end,
  } }
