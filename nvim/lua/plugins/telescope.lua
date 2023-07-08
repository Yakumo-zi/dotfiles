return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
            },
          },
        },
        extensions = {
          file_browser = {
            theme = "ivy",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
              ["i"] = {
                -- your custom insert mode mappings
              },
              ["n"] = {
                -- your custom normal mode mappings
              },
            },
          },
        },
      })

      -- Enable telescope fzf native, if installed
      pcall(require("telescope").load_extension, "fzf")
      require("telescope").load_extension("file_browser")
      local map = require("helpers.keys").map
      map("n", "<leader>fr", require("telescope.builtin").oldfiles, "Recently opened")
      map("n", "<leader><space>", require("telescope.builtin").buffers, "Open buffers")
      map("n", "<leader>/", function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, "Search in current buffer")

      map("n", "<leader>sf", require("telescope.builtin").find_files, "Files")
      map("n", "<leader>sh", require("telescope.builtin").help_tags, "Help")
      map("n", "<leader>sw", require("telescope.builtin").grep_string, "Current word")
      map("n", "<leader>sg", require("telescope.builtin").live_grep, "Grep")
      map("n", "<leader>sd", require("telescope.builtin").diagnostics, "Diagnostics")

      map("n", "<C-p>", require("telescope.builtin").keymaps, "Search keymaps")
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
}
