return {
  snippets = { preset = "luasnip" },
  appearance = { nerd_font_variant = "mono" },
  fuzzy = { implementation = "prefer_rust" },
  sources = {
    default = function()
      local success, node = pcall(vim.treesitter.get_node)
      if
        success
        and node
        and vim.tbl_contains(
          { "comment", "line_comment", "block_comment" },
          node:type()
        )
      then
        return { "buffer" }
      end

      return { "lazydev", "lsp", "snippets", "path", "buffer" }
    end,
    providers = {
      buffer = {
        name = "buffer",
        max_items = 4,
        score_offset = -2,
      },
      emoji = {
        name = "Emoji",
        module = "blink-emoji",
      },
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        fallbacks = { "LSP" },
      },
      lsp = {
        name = "LSP",
      },
      path = {
        name = "path",
        opts = {
          get_cwd = function(_) return vim.fn.getcwd() end,
        },
      },
      snippets = {
        name = "snippets",
        should_show_items = function(ctx)
          return ctx.trigger.initial_kind ~= "trigger_character"
        end,
      },
    },
  },

  keymap = {
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<Tab>"] = {
      function(cmp)
        if cmp.snippet_active() then
          return cmp.accept()
        else
          return cmp.select_and_accept()
        end
      end,
      "snippet_forward",
      "fallback",
    },
    ["<S-Tab>"] = { "snippet_backward", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback" },
    ["<C-n>"] = { "select_next", "fallback" },
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    ["<Up>"] = { "fallback" },
    ["<Down>"] = { "fallback" },
  },
  cmdline = {
    keymap = {
      ["<Tab>"] = { "select_and_accept" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
    },
    completion = {
      menu = { auto_show = true },
    },
  },

  completion = {
    keyword = {
      range = "full",
    },
    list = {
      selection = { preselect = true, auto_insert = false },
    },
    ghost_text = { enabled = true },
    menu = {
      border = "rounded",
      draw = {},
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
      window = {
        border = "rounded",
      },
    },
  },
  signature = {
    enabled = true,
    window = { border = "rounded" },
  },
}
