return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "classic",
        options = {
          show_source = {
            enabled = true,
          },
          add_messages = {
            display_count = true,
          },
          multilines = {
            enabled = true,
          },
        },
      })
      vim.diagnostic.config({ virtual_text = false }) -- Disable default virtual text
    end,
  },
}
