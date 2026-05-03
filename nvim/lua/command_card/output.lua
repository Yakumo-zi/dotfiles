local config = require("command_card.config")
local util = require("command_card.util")

local M = {}

local uv = vim.uv or vim.loop
local states = {}

local function set_modifiable(bufnr, value)
  if vim.api.nvim_buf_is_valid(bufnr) then vim.bo[bufnr].modifiable = value end
end

local function append_lines(bufnr, lines)
  if not vim.api.nvim_buf_is_valid(bufnr) then return end
  if not lines or vim.tbl_isempty(lines) then return end

  set_modifiable(bufnr, true)
  vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, lines)
  set_modifiable(bufnr, false)

  local win = vim.fn.bufwinid(bufnr)
  if win ~= -1 then
    pcall(
      vim.api.nvim_win_set_cursor,
      win,
      { vim.api.nvim_buf_line_count(bufnr), 0 }
    )
  end
end

local function replace_first_line(bufnr, line)
  if not vim.api.nvim_buf_is_valid(bufnr) then return end

  set_modifiable(bufnr, true)
  vim.api.nvim_buf_set_lines(bufnr, 0, 1, false, { line })
  set_modifiable(bufnr, false)
end

local function prepare_window()
  local opts = config.get().output

  if opts.open == "vsplit" then
    vim.cmd("botright vsplit")
  elseif opts.open == "tab" then
    vim.cmd("tabnew")
  elseif opts.open == "current" then
    -- Reuse the current window.
  else
    vim.cmd("botright split")
    vim.cmd(("resize %d"):format(opts.height))
  end
end

local function command_lines(entry, ctx, cwd)
  local command = entry.command

  return {
    "Command Card [running]",
    "",
    "Command: " .. command.name,
    "Source: " .. entry.source_label,
    "Cwd: " .. cwd,
    "Started: " .. util.format_time(os.time()),
    "",
    "$ " .. command.cmd,
    "",
    "--- stdout ---",
  }
end

function M.open(entry, ctx, cwd)
  prepare_window()

  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(0, bufnr)

  vim.bo[bufnr].buftype = "nofile"
  vim.bo[bufnr].bufhidden = "hide"
  vim.bo[bufnr].swapfile = false
  vim.bo[bufnr].filetype = "command-card-output"

  vim.api.nvim_buf_set_name(
    bufnr,
    ("Command Card: %s"):format(entry.command.name)
  )

  set_modifiable(bufnr, true)
  vim.api.nvim_buf_set_lines(
    bufnr,
    0,
    -1,
    false,
    command_lines(entry, ctx, cwd)
  )
  set_modifiable(bufnr, false)

  states[bufnr] = {
    started_hr = uv.hrtime(),
    stderr_started = false,
    job_id = nil,
    stopped = false,
  }

  vim.keymap.set("n", "q", "<cmd>close<CR>", {
    buffer = bufnr,
    silent = true,
    desc = "Close output",
  })
  vim.keymap.set("n", "<C-c>", function() M.stop(bufnr) end, {
    buffer = bufnr,
    silent = true,
    desc = "Stop command",
  })
  vim.keymap.set("n", "R", function()
    local state = states[bufnr]
    if state and state.rerun then state.rerun() end
  end, {
    buffer = bufnr,
    silent = true,
    desc = "Rerun command",
  })

  return bufnr
end

function M.attach(bufnr, job_id, rerun)
  if not states[bufnr] then return end
  states[bufnr].job_id = job_id
  states[bufnr].rerun = rerun
end

function M.append(bufnr, stream, data)
  vim.schedule(function()
    if not states[bufnr] then return end
    if not data or vim.tbl_isempty(data) then return end

    local lines = vim.deepcopy(data)
    if lines[#lines] == "" then table.remove(lines, #lines) end
    if vim.tbl_isempty(lines) then return end

    local state = states[bufnr]
    if stream == "stderr" and not state.stderr_started then
      state.stderr_started = true
      table.insert(lines, 1, "--- stderr ---")
      table.insert(lines, 1, "")
    end

    append_lines(bufnr, lines)
  end)
end

function M.finish(bufnr, code)
  vim.schedule(function()
    local state = states[bufnr]
    if not state then return end

    state.job_id = nil
    local duration = (uv.hrtime() - state.started_hr) / 1000000000
    local status = code == 0 and "success" or "failed"
    if state.stopped then status = "stopped" end

    replace_first_line(bufnr, "Command Card [" .. status .. "]")
    append_lines(bufnr, {
      "",
      ("Exit code: %s"):format(code),
      ("Duration: %.2fs"):format(duration),
    })
  end)
end

function M.stop(bufnr)
  local state = states[bufnr]
  if not state or not state.job_id then return end

  state.stopped = true
  vim.fn.jobstop(state.job_id)
  append_lines(bufnr, { "", "Stopping command..." })
end

return M
