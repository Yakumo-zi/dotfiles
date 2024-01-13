return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',
    'L3MON4D3/LuaSnip',
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    cmp.setup({
      enabled = true,
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
      }, {
        { name = "path" },
        { name = "buffer" },
        { name = "luasnip" },
      }),
      mapping = require("plugins.lsp_config.keymaps").auto_cmp(cmp, luasnip),
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
}
