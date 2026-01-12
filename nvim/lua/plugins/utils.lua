return {
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      float = {
        padding = 5, -- 增加内边距让它不要贴着屏幕边缘
        max_width = 120, -- 限制最大宽度，防止在大屏上太宽
        max_height = 30, -- 限制高度
        border = "rounded",
        win_options = {
          winblend = 0, -- 透明度 (0-100)，需要终端支持
        },
        override = function(conf) return conf end,
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    lazy = false,
    keys = {
      { "-", "<CMD>Oil --float<CR>", desc = "Open parent directory" },
    },
  },
}
