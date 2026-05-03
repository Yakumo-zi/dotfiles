local env = require("env")

local keys = {
  { "<leader>pf", "<cmd>FzfLua files<cr>", desc = "Find Files" },
  { "<leader>pb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
  { "<leader>ph", "<cmd>FzfLua help_tags<cr>", desc = "Help" },
  {
    "<leader>pd",
    "<cmd>FzfLua lsp_definitions<cr>",
    desc = "Go to Definition",
  },
  { "<leader>pr", "<cmd>FzfLua lsp_references<cr>", desc = "References" },
  { "<leader>pk", "<cmd>FzfLua keymaps<cr>", desc = "Keymaps" },
  {
    "<leader>ca",
    "<cmd>FzfLua lsp_code_actions<cr>",
    desc = "Code Actions",
  },
}

if env.executable("rg") then
  table.insert(keys, 2, {
    "<leader>ps",
    "<cmd>FzfLua live_grep<cr>",
    desc = "Grep Project",
  })
end

return {
  {
    "ibhagwan/fzf-lua",
    enabled = env.executable("fzf"),
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local fzf = require("fzf-lua")
      local preview = { layout = "flex" }
      if env.executable("bat") then preview.default = "bat" end

      fzf.setup({
        winopts = {
          border = "rounded",
          preview = preview,
        },
        lsp = {
          code_actions = {
            previewer = "codeaction_native",
          },
        },
      })
      fzf.register_ui_select()
    end,
    keys = keys,
  },
}
