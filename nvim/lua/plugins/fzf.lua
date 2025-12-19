return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local fzf = require("fzf-lua")
      fzf.setup({
        winopts = {
          preview = {
            default = "bat",
            layout = "flex",
          },
        },
        lsp = {
          code_actions = {
            previewer = "codeaction_native",
          },
        },
      })
      fzf.register_ui_select()
    end,
    keys = {
      { "<leader>pf", "<cmd>FzfLua files<cr>", desc = "Find Files" },
      { "<leader>ps", "<cmd>FzfLua live_grep<cr>", desc = "Grep Project" },
      { "<leader>pb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
      { "<leader>ph", "<cmd>FzfLua help_tags<cr>", desc = "Help" },
      { "<leader>pd", "<cmd>FzfLua lsp_definitions<cr>", desc = "Go to Definition" },
      { "<leader>pr", "<cmd>FzfLua lsp_references<cr>", desc = "References" },
      { "<leader>pk", "<cmd>FzfLua keymaps<cr>", desc = "Keymaps" },
      { "<leader>ca", "<cmd>FzfLua lsp_code_actions<cr>", desc = "Code Actions" },
    },
  },
}
