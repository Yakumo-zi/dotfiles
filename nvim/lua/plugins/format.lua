local env = require("env")

local formatters_by_ft = {
  ["lua"] = { "stylua" },
  ["cpp"] = { "clang-format" },
  ["c"] = { "clang-format" },
  ["go"] = { "goimports", "gofmt" },
  ["rust"] = { "rustfmt" },
  ["javascript"] = { "prettier" },
  ["javascriptreact"] = { "prettier" },
  ["typescript"] = { "prettier" },
  ["python"] = { "ruff_format" },
  ["json"] = { "prettier" },
  ["zig"] = { "zigfmt" },
}

return {
  {
    "stevearc/conform.nvim",
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>fm",
        function() require("conform").format({ lsp_format = "fallback" }) end,
        desc = "Format Files",
      },
    },
    opts = function()
      return {
        formatters_by_ft = env.filter_formatters_by_ft(
          formatters_by_ft,
          env.formatter_commands
        ),
      }
    end,
  },
}
