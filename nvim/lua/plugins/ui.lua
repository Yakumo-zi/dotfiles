local env = require("env")

return {
  { "nvim-tree/nvim-web-devicons", opts = {} },
  {
    "echasnovski/mini.statusline",
    opts = {
      use_icons = true,
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    enabled = env.executable("git"),
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "latte",
      term_colors = true,
      dim_inactive = {
        enabled = true,
        shade = "light",
        percentage = 0.12,
      },
      styles = {
        comments = { "italic" },
        conditionals = {},
        loops = {},
        functions = { "bold" },
        keywords = { "italic" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = { "bold" },
        operators = {},
      },
      integrations = {
        barbar = true,
        blink_cmp = true,
        fidget = true,
        fzf = env.executable("fzf"),
        gitsigns = env.executable("git"),
        illuminate = true,
        mini = true,
        notify = true,
      },
      custom_highlights = function(colors)
        return {
          CursorLine = { bg = colors.surface0 },
          CursorLineNr = { fg = colors.peach, style = { "bold" } },
          FloatBorder = { fg = colors.blue, bg = colors.mantle },
          IndentLine = { fg = colors.surface1 },
          IndentLineCurrent = { fg = colors.lavender },
          LineNr = { fg = colors.overlay0 },
          NormalFloat = { bg = colors.mantle },
          Pmenu = { bg = colors.mantle },
          PmenuSel = { bg = colors.surface1, style = { "bold" } },
          StatusLine = { fg = colors.text, bg = colors.mantle },
          StatusLineNC = { fg = colors.overlay1, bg = colors.crust },
          Visual = { bg = colors.surface1 },
          WinSeparator = { fg = colors.surface1 },
        }
      end,
    },
  },
  {
    "romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
      "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    keys = {
      { "<Tab>", "<cmd>BufferNext<CR>", desc = "Next buffer" },
      { "<S-Tab>", "<cmd>BufferPrevious<CR>", desc = "Previous buffer" },
      { "<leader>bc", "<cmd>BufferClose<CR>", desc = "Close buffer" },
    },
    opts = {
      animation = true,
      highlight_inactive_file_icons = true,
      icons = {
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = { enabled = true },
          [vim.diagnostic.severity.WARN] = { enabled = true },
        },
        gitsigns = {
          added = { enabled = true, icon = "+" },
          changed = { enabled = true, icon = "~" },
          deleted = { enabled = true, icon = "-" },
        },
        modified = { button = "●" },
        separator = { left = "▎", right = "" },
        separator_at_end = false,
      },
    },
    version = "^1.0.0", -- optional: only update when a new 1.x version is released
  },
  {
    "nvimdev/indentmini.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      char = "▏",
      minlevel = 1,
    },
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
        background_colour = "#eff1f5",
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
  {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      vim.opt.termguicolors = true
      require("nvim-highlight-colors").setup({})
    end,
  },
}
