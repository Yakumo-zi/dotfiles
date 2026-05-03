local context = require("command_card.context")
local output = require("command_card.output")
local util = require("command_card.util")

local M = {}

local function shell_command(command)
  return { vim.o.shell, vim.o.shellcmdflag, command }
end

function M.run(entry, ctx)
  if not entry or not entry.command then return end

  ctx = ctx or context.build()
  local cwd = context.resolve_cwd(entry.command, ctx)
  if vim.fn.isdirectory(cwd) ~= 1 then
    util.notify(("Invalid cwd: %s"):format(cwd), vim.log.levels.ERROR)
    return
  end

  local bufnr = output.open(entry, ctx, cwd)
  local job_id = vim.fn.jobstart(shell_command(entry.command.cmd), {
    cwd = cwd,
    stdout_buffered = false,
    stderr_buffered = false,
    on_stdout = function(_, data) output.append(bufnr, "stdout", data) end,
    on_stderr = function(_, data) output.append(bufnr, "stderr", data) end,
    on_exit = function(_, code) output.finish(bufnr, code) end,
  })

  if job_id <= 0 then
    output.append(bufnr, "stderr", { "Failed to start command" })
    output.finish(bufnr, -1)
    return
  end

  output.attach(bufnr, job_id, function() M.run(entry, ctx) end)
end

return M
