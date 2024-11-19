local options = {
  window = {
    completion = {
      border = "rounded", -- 使用圆角边框
    },
    documentation = {
      border = "rounded", -- 使用圆角边框
    },
  },
  sources = {
    { name = "codeium" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "treesitter" },
    { name = "path" },
  },
  formatting = {
    format = require('lspkind').cmp_format({
      mode = "symbol",
      maxwidth = 50,
      ellipsis_char = '...',
      symbol_map = { Codeium = "", }
    })
  }
}



return options
