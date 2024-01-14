-- 快速查找插件
return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>",  "n", desc = "Telescope find files" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",     "n", desc = "Telescope find buffers" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",   "n", desc = "Telescope live grep" },
    { "<leader>fd", "<cmd>Telescope diagnostics<cr>", "n", desc = "Telescope find diagnostics" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>",   "n", desc = "Telescope help tags" },
    { "<leader>fo", "<cmd>Telescope oldfiles<cr>",    "n", desc = "Telescope recently opened files" },
  },
}
