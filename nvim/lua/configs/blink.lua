local opts = {
  completion = {
    list = {
      selection = {
        preselect = false,
      },
    },
    menu = {
      border = "rounded",
      draw = {},
    },
    documentation = {
      window = {
        border = "rounded",
      },
    },
  },
  sources = {
    default = { "avante", "lsp", "path", "snippets", "buffer" },
    providers = {
      avante = {
        module = "blink-cmp-avante",
        name = "Avante",
      },
    },
  },
}

return opts
