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
    {
      name = "copilot",
      group_index = 1,
      priority = 100,
    },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "treesitter" },
    { name = "path" },
  },
}



return options
