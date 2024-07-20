-- 快速查找插件
return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>fb", "<cmd>Telescope buffers<cr>",     "n", desc = "Telescope find buffers" },
    { "<leader>fd", "<cmd>Telescope diagnostics<cr>", "n", desc = "Telescope find diagnostics" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>",   "n", desc = "Telescope help tags" },
    { "<leader>fo", "<cmd>Telescope oldfiles<cr>",    "n", desc = "Telescope recently opened files" },
    { "<leader>fp", "<cmd>Telescope projects<cr>",    "n", desc = "Telescope projects" },
  },
  config = function()
    local map = require("helpers.keys").map
    local utils = require("helpers.utils")

    local live_grep_from_project_root = function()
      require("telescope.builtin").live_grep({
        cwd = utils.cached_get_current_file_root_path(),
      })
    end
    local find_files_from_project_root = function()
      require("telescope.builtin").find_files({
        cwd = utils.cached_get_current_file_root_path(),
      })
    end

    map("n", "<leader>fg", live_grep_from_project_root, "Telescope live grep from project root")
    map("n", "<leader>ff", find_files_from_project_root, "Telescope find files from project root")

    local actions = require("telescope.actions")
    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = actions.close,
          },
        },
      },
    })
  end,
}
