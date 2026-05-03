local config = require("command_card.config")
local context = require("command_card.context")
local input = require("command_card.input")
local runner = require("command_card.runner")
local store = require("command_card.store")
local util = require("command_card.util")

local M = {}

local active

local function size()
  local ui = config.get().ui
  local width = math.floor(vim.o.columns * ui.width)
  local height = math.floor(vim.o.lines * ui.height)

  width = math.max(52, math.min(width, vim.o.columns - 4))
  height = math.max(12, math.min(height, vim.o.lines - 4))

  return width, height
end

local function current_item(state)
  if not state or not vim.api.nvim_win_is_valid(state.win) then return nil end
  local line = vim.api.nvim_win_get_cursor(state.win)[1]
  return state.line_to_item[line]
end

local function close(state)
  state = state or active
  if not state then return end
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
  end
  if active == state then active = nil end
end

local function filtered_items(state)
  if not state.filter or state.filter == "" then return state.items end

  local filter = state.filter:lower()
  return vim.tbl_filter(function(item)
    local command = item.command
    local haystack = table
      .concat({
        command.name or "",
        command.cmd or "",
        command.description or "",
        item.source_label or "",
      }, " ")
      :lower()
    return haystack:find(filter, 1, true) ~= nil
  end, state.items)
end

local function set_lines(state, lines)
  vim.bo[state.buf].modifiable = true
  vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, lines)
  vim.bo[state.buf].modifiable = false
end

local function add_highlights(state, footer_line)
  vim.api.nvim_buf_clear_namespace(state.buf, state.ns, 0, -1)
  vim.api.nvim_buf_add_highlight(state.buf, state.ns, "Title", 0, 0, -1)
  vim.api.nvim_buf_add_highlight(state.buf, state.ns, "Comment", 1, 0, -1)
  vim.api.nvim_buf_add_highlight(
    state.buf,
    state.ns,
    "Comment",
    footer_line - 1,
    0,
    -1
  )
end

local function render(state)
  local width = vim.api.nvim_win_get_width(state.win)
  local items = filtered_items(state)
  local lines = {}
  state.line_to_item = {}
  state.first_item_line = nil

  local title = ("Command Card  %s  %s"):format(
    state.ctx.filetype ~= "" and state.ctx.filetype or "no-ft",
    state.ctx.project_name or "no-project"
  )
  table.insert(lines, " " .. title)

  local filter = state.filter
      and state.filter ~= ""
      and ("  filter: " .. state.filter)
    or ""
  table.insert(lines, (" %d command(s)%s"):format(#items, filter))
  table.insert(lines, "")

  if #items == 0 then
    table.insert(lines, " No commands for this context")
    table.insert(lines, "")
    table.insert(lines, " Press a to add a command")
  else
    local name_width = math.max(16, math.floor(width * 0.26))
    local source_width = math.max(14, math.floor(width * 0.2))
    local command_width = width - name_width - source_width - 10

    table.insert(
      lines,
      ("   %s  %s  %s"):format(
        util.pad("Name", name_width),
        util.pad("Source", source_width),
        "Command"
      )
    )

    for index, item in ipairs(items) do
      local line = (" %2d %s  %s  %s"):format(
        index,
        util.pad(item.command.name, name_width),
        util.pad(item.source_label, source_width),
        util.truncate(item.command.cmd, command_width)
      )
      table.insert(lines, line)
      state.line_to_item[#lines] = item
      state.first_item_line = state.first_item_line or #lines
    end
  end

  table.insert(lines, "")
  table.insert(
    lines,
    " enter run   a add   e edit   d delete   / filter   r reload   q close"
  )

  set_lines(state, lines)
  add_highlights(state, #lines)

  if state.win and vim.api.nvim_win_is_valid(state.win) then
    pcall(
      vim.api.nvim_win_set_cursor,
      state.win,
      { state.first_item_line or 1, 0 }
    )
  end
end

local function reload(state)
  state.ctx = context.build()
  state.items = store.list(state.ctx)
  render(state)
end

local function map(state, lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, {
    buffer = state.buf,
    nowait = true,
    silent = true,
    desc = desc,
  })
end

local function set_keymaps(state)
  map(state, "q", function() close(state) end, "Close")
  map(state, "<Esc>", function() close(state) end, "Close")
  map(state, "r", function()
    store.reload()
    reload(state)
  end, "Reload")
  map(state, "<CR>", function()
    local item = current_item(state)
    if not item then return end
    close(state)
    runner.run(item, state.ctx)
  end, "Run command")
  map(state, "a", function()
    input.add(state.ctx, function()
      store.reload()
      reload(state)
    end)
  end, "Add command")
  map(state, "e", function()
    local item = current_item(state)
    if not item then return end
    input.edit(item, state.ctx, function()
      store.reload()
      reload(state)
    end)
  end, "Edit command")
  map(state, "d", function()
    local item = current_item(state)
    if not item then return end

    require("command_card.confirm").open({
      message = ("Delete command '%s'?"):format(item.command.name),
      on_confirm = function()
        if store.delete(item) then
          util.notify("Command deleted")
          store.reload()
          reload(state)
        else
          util.notify("Failed to delete command", vim.log.levels.ERROR)
        end
      end,
    })
  end, "Delete command")
  map(state, "/", function()
    require("command_card.filter").open(state.filter, function(value)
      state.filter = util.trim(value)
      render(state)
    end)
  end, "Filter")
end

function M.open()
  if active and active.win and vim.api.nvim_win_is_valid(active.win) then
    vim.api.nvim_set_current_win(active.win)
    return
  end

  local width, height = size()
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local state = {
    buf = vim.api.nvim_create_buf(false, true),
    ctx = context.build(),
    line_to_item = {},
    ns = vim.api.nvim_create_namespace("command-card"),
    filter = "",
  }
  state.items = store.list(state.ctx)

  state.win = vim.api.nvim_open_win(state.buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = config.get().ui.border,
    title = " Command Card ",
    title_pos = "center",
  })

  vim.bo[state.buf].buftype = "nofile"
  vim.bo[state.buf].bufhidden = "wipe"
  vim.bo[state.buf].swapfile = false
  vim.bo[state.buf].filetype = "command-card"
  vim.wo[state.win].cursorline = true
  vim.wo[state.win].number = false
  vim.wo[state.win].relativenumber = false
  vim.wo[state.win].signcolumn = "no"

  render(state)
  set_keymaps(state)
  active = state
end

return M
