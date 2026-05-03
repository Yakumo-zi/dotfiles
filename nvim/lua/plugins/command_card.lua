local config_root =
  vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h:h")

return {
  {
    "command-card.nvim",
    dir = config_root,
    lazy = true,
    cmd = { "CommandCard", "CommandCardAdd", "CommandCardReload" },
    keys = {
      {
        "<leader>cc",
        function() require("command_card").open() end,
        desc = "Command Card",
      },
      {
        "<leader>cA",
        function() require("command_card").add() end,
        desc = "Add Command Card command",
      },
    },
    opts = {
      project = {
        root_markers = { ".git", "go.mod", "package.json", "pyproject.toml" },
      },
    },
    config = function(_, opts) require("command_card").setup(opts) end,
  },
}
