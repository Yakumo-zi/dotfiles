-- 功能插件汇总
return {
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    opts = {}
  },
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    lazy = false,
  },
  {
    { 'akinsho/toggleterm.nvim', version = "*", opts = { --[[ things you want to change go here]] } }
  },
  "folke/which-key.nvim",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
  }
}
