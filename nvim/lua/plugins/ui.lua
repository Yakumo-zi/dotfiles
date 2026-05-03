local env = require("env")

return {
  {
    "rrethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("illuminate").configure({
        delay = 350,
        filetypes_denylist = {
          "aerial",
          "NvimTree",
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
        background_colour = "#303446",
        fps = 60,
        render = "compact",
        stages = "fade_in_slide_out",
        timeout = 2500,
      })
      vim.notify = require("notify")
    end,
  },
  {
    "f-person/git-blame.nvim",
    enabled = env.executable("git"),
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
