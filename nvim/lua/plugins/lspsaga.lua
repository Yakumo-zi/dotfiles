return {
  "glepnir/lspsaga.nvim",
  event = "LspAttach",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    --Please make sure you install markdown and markdown_inline parser
    { "nvim-treesitter/nvim-treesitter" },
  },
  config = function()
    require("lspsaga").setup({
      ui = {
        -- This option only works in Neovim 0.9
        title = true,
        -- Border type can be single, double, rounded, solid, shadow.
        border = "single",
        winblend = 0,
        expand = "",
        collapse = "",
        code_action = "💡",
        hover = " ",
        kind = {
          ["Folder"] = { " ", "@comment" },
          ["Function"] = { " ", "Function" },
          ["String"] = { " ", "String" },
          ["Number"] = { " ", "Number" },
          ["Array"] = { " ", "Type" },
        },
      },
    })
    local map = require("helpers.keys").map
    map("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", "Lsp Finder")
    map({ "n", "v" }, "<leader>la", "<cmd>Lspsaga code_action<CR>", "Code action")
    map("n", "gd", "<cmd>Lspsaga goto_definition<CR>", "Goto Definition")
    -- map("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>", "Goto Type Definition")
    map("n", "K", "<cmd>Lspsaga hover_doc<CR>", "Hover Documetn")
    -- map({ "n", "t" }, "<C-t>", "<cmd>Lspsaga term_toggle<CR>", "Float Terminal Toggle")
    map("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>", "Peek Type Definition")
    map("n", "gp", "<cmd>Lspsaga peek_definition<CR>", "Peek Definition")
    map("n", "lr", "<cmd>Lspsaga rename<CR>", "Peek Definition")
  end,
}
