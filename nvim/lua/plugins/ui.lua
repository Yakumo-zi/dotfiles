return {
  -- bufferline
  {
    "akinsho/bufferline.nvim",
    version = "v3.*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {},
  },
  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
    })
    end,
  },
  -- nvim tree
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    keys={
      {"<leader>e","<cmd>NvimTreeToggle<cr>","n",desc="Toogle nvim tree"},
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({})
    end,
  },
}
