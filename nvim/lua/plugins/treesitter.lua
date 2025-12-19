return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdate", "TSInstall" },
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "html",
          "css",
          "typescript",
          "javascript",
          "c",
          "cpp",
          "go",
          "rust",
          "bash",
          "python",
        },
        highlight = {
          enable = true,
        },
        indent = { enable = true },
        fold = { enable = false },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@call.outer",
              ["ic"] = "@call.inner",
              ["as"] = {
                query = "@local.scope",
                query_group = "locals",
                desc = "Select language scope",
              },
              ["id"] = "@conditional.inner",
              ["ad"] = "@conditional.outer",
            },
            selection_modes = {
              ["@parameter.outer"] = "v",
              ["@function.outer"] = "V",
              ["@class.outer"] = "<c-v>",
            },
            include_surrounding_whitespace = true,
          },
        },
      })
    end,
  },
}