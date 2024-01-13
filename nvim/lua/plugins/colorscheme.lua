return {
  "folke/tokyonight.nvim",
  "navarasu/onedark.nvim",
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      local opts={ 
        flavour = "frappe",
      }
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end
  },
}
