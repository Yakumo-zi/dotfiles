local utils = require("helpers.utils")
vim.api.nvim_create_user_command("Run", function()
  vim.notify("Hello", vim.log.levels.WARN, {})
end, {})
