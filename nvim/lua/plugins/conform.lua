return {
  {
    "stevearc/conform.nvim",
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>fm",
        function() require("conform").format({ lsp_fallback = true }) end,
        desc = "Format Files",
      },
    },
    opts = {
      formatters_by_ft = {
        ["lua"] = { "stylua" },
        ["cpp"] = { "clang-format" },
        ["c"] = { "clang-format" },
        ["go"] = { "goimports", "gofmt" },
        ["rust"] = { "rustfmt" },
        ["javascript"] = { "prettier" },
        ["javascriptreact"] = { "prettier" },
        ["typescript"] = { "prettier" },
        ["python"] = { "ruff" },
        ["json"] = { "prettier" },
      },
    },
  },
}
