local config = require("command_card.config")

local M = {}

local function create_command(name, callback, opts)
  pcall(vim.api.nvim_del_user_command, name)
  vim.api.nvim_create_user_command(name, callback, opts or {})
end

function M.setup(opts)
  config.setup(opts)

  create_command("CommandCard", function() M.open() end, {
    desc = "Open Command Card",
  })
  create_command("CommandCardAdd", function() M.add() end, {
    desc = "Add a Command Card command",
  })
  create_command("CommandCardReload", function()
    require("command_card.store").reload()
    require("command_card.util").notify("Command Card reloaded")
  end, {
    desc = "Reload Command Card commands",
  })
end

function M.open() require("command_card.picker").open() end

function M.add()
  require("command_card.input").add(require("command_card.context").build())
end

function M.run(entry, ctx) require("command_card.runner").run(entry, ctx) end

return M
