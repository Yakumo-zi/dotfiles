return {
  { "nvim-tree/nvim-web-devicons", opts = {} },
  { "echasnovski/mini.statusline", opts = {} },
  { "lewis6991/gitsigns.nvim", opts = {} },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "latte",
    },
  },
  {
    "romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
      "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {},
    version = "^1.0.0", -- optional: only update when a new 1.x version is released
  },
  {
    "nvimdev/indentmini.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  {
    "rrethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("illuminate").configure({
        delay = 350,
        filetypes_denylist = {
          "aerial",
          "neo-tree",
        },
        modes_denylist = { "v", "V" },
        under_cursor = false,
      })
    end,
  },
  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "<leader>so", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {},
  },
  {
    "rcarriga/nvim-notify",
    event = "VimEnter",
    config = function()
      require("notify").setup({
        fps = 60,
      })
      vim.notify = require("notify")
    end,
  },
  {
    "f-person/git-blame.nvim",
    lazy = true,
    keys = {
      { "<leader>gb", "<cmd>GitBlameToggle<CR>", desc = "GitBlameToogle" },
    },
    opts = {
      enabled = true,
      message_template = " <summary> • <date> • <author>",
      date_format = "%Y-%m-%d %r",
      virtual_text_column = 1,
    },
  },
}
