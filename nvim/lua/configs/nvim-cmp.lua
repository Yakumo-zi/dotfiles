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
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "treesitter" },
    { name = "path" },
  },
}


return options
