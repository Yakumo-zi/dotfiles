return {
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    lazy = false,
    keys = {
      { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
    },
  },
}
