return {
  "saghen/blink.cmp",
  version = "1.*",
  event = "InsertEnter",
  dependencies = {
    "rafamadriz/friendly-snippets",
    {
      "L3MON4D3/LuaSnip",
      config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
    },
    { "windwp/nvim-autopairs", opts = {} },
  },
  opts = function() return require("plugins.configs.blink") end,
}
