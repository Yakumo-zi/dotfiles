local context = require("command_card.context")

local M = {}

function M.add(ctx, callback)
  ctx = ctx or context.build()
  require("command_card.form").add(ctx, callback)
end

function M.edit(entry, ctx, callback)
  if not entry then return end

  if type(ctx) == "function" then
    callback = ctx
    ctx = nil
  end

  require("command_card.form").edit(entry, ctx or context.build(), callback)
end

return M
