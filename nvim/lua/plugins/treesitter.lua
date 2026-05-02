local parsers = {
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

return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = function() require("nvim-treesitter").install(parsers):wait(300000) end,
  },
}
