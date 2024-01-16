return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
  },
  {
    "navarasu/onedark.nvim",
    lazy = true
  },
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    priority = 1000,
    config = function()
      local opts = {
        flavour = "frappe",
      }
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end
  },
  {
    'sainnhe/everforest',
    -- lazy = true,
    priority = 1000,
    config = function()
      vim.g.everforest_diagnostic_line_highlight = 1
      vim.cmd.colorscheme("everforest")
    end
  }
}
