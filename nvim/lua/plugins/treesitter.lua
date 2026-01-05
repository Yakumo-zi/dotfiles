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
      local ensure_installed = {
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
      }

      local has_tree_sitter_cli = vim.fn.executable("tree-sitter") == 1
      local has_swift_parser = vim.fn.filereadable(
        vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/parser/swift.so"
      ) == 1

      if has_tree_sitter_cli or has_swift_parser then
        table.insert(ensure_installed, "swift")
      end

      require("nvim-treesitter.configs").setup({
        ensure_installed = ensure_installed,
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
