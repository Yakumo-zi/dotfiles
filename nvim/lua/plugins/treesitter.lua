return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install(
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
        "python"
      )
    end,
  },
}
