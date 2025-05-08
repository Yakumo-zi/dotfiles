local options = {
  formatters_by_ft = {
    ["javascript"] = { "prettier" },
    ["javascriptreact"] = { "prettier" },
    ["typescript"] = { "prettier" },
    ["typescriptreact"] = { "prettier" },
    ["css"] = { "prettier" },
    ["html"] = { "prettier" },
    ["json"] = { "prettier" },
    ["jsonc"] = { "prettier" },
    ["yaml"] = { "prettier" },
    ["markdown"] = { "prettier" },
    ["lua"] = { "stylua" },
    ["cpp"] = { "clang-format" },
    ["c"] = { "clang-format" },
    ["go"] = { "goimports", "gofmt" },
    ["rust"] = { "rustfmt" },
    ["_"] = { "trim_whitespace" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
