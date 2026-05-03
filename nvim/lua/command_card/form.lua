local config = require("command_card.config")
local store = require("command_card.store")
local util = require("command_card.util")

local M = {}

local valid_scopes = {
  global = true,
  filetype = true,
  project = true,
}

local valid_cwd = {
  project = true,
  file = true,
  nvim = true,
  custom = true,
}

local function window_size()
  local width = math.floor(vim.o.columns * 0.62)
  local height = 15

  width = math.max(58, math.min(width, vim.o.columns - 4))
  height = math.max(12, math.min(height, vim.o.lines - 4))

  return width, height
end

local function command_tags(command)
  if type(command.tags) ~= "table" then return "" end
  return table.concat(command.tags, ", ")
end

local function lines_for(entry, mode)
  local command = entry.command

  return {
    mode == "add" and " Command Creator" or " Command Editor",
    " source: " .. entry.source_label,
    " id: " .. (command.id or ""),
    "",
    " name: " .. (command.name or ""),
    " cmd: " .. (command.cmd or ""),
    " scope: " .. (entry.scope or "global"),
    " cwd: " .. (command.cwd or "project"),
    " cwd_path: " .. (command.cwd_path or ""),
    " description: " .. (command.description or ""),
    " tags: " .. command_tags(command),
    "",
    " cwd values: project | file | nvim | custom",
    " scope values: global | filetype | project",
    " i edit fields   s save   q cancel",
  }
end

local function parse_tags(value)
  local tags = {}
  for tag in (value or ""):gmatch("[^,]+") do
    tag = util.trim(tag)
    if tag ~= "" then table.insert(tags, tag) end
  end
  return tags
end

local function parse(bufnr)
  local parsed = {}

  for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
    local key, value = line:match("^%s*([%w_]+):%s*(.*)$")
    if key then parsed[key] = util.trim(value) end
  end

  local values = {
    name = parsed.name or "",
    cmd = parsed.cmd or "",
    scope = parsed.scope or "",
    cwd = parsed.cwd or "",
    cwd_path = parsed.cwd_path ~= "" and parsed.cwd_path or nil,
    description = parsed.description or "",
    tags = parse_tags(parsed.tags),
  }

  if values.name == "" then return nil, "name is required" end
  if values.cmd == "" then return nil, "cmd is required" end
  if not valid_scopes[values.scope] then
    return nil, "scope must be one of: global, filetype, project"
  end
  if not valid_cwd[values.cwd] then
    return nil, "cwd must be one of: project, file, nvim, custom"
  end
  if values.cwd == "custom" and not values.cwd_path then
    return nil, "cwd_path is required when cwd is custom"
  end
  if values.cwd ~= "custom" then values.cwd_path = nil end

  return values
end

local function add_highlights(bufnr, ns)
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  vim.api.nvim_buf_add_highlight(bufnr, ns, "Title", 0, 0, -1)

  for index, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
    local start_col, end_col = line:find("^%s*[%w_]+:")
    if start_col then
      vim.api.nvim_buf_add_highlight(
        bufnr,
        ns,
        "Identifier",
        index - 1,
        start_col - 1,
        end_col
      )
    end
  end

  local count = vim.api.nvim_buf_line_count(bufnr)
  vim.api.nvim_buf_add_highlight(bufnr, ns, "Comment", count - 3, 0, -1)
  vim.api.nvim_buf_add_highlight(bufnr, ns, "Comment", count - 2, 0, -1)
  vim.api.nvim_buf_add_highlight(bufnr, ns, "Comment", count - 1, 0, -1)
end

local function close(win)
  if win and vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_close(win, true)
  end
end

local function default_scope(ctx)
  if ctx.project_name or ctx.project_root then return "project" end
  if ctx.filetype and ctx.filetype ~= "" then return "filetype" end
  return "global"
end

local function default_entry(ctx)
  local scope = default_scope(ctx)
  local label = scope == "filetype" and ("filetype:" .. ctx.filetype)
    or scope == "project" and ("project:" .. (ctx.project_name or "current"))
    or "global"

  return {
    scope = scope,
    source_label = label,
    command = {
      name = "",
      cmd = "",
      cwd = scope == "global" and "nvim" or "project",
      description = "",
      tags = {},
    },
  }
end

local function open_form(entry, ctx, callback, mode)
  local width, height = window_size()
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)
  local bufnr = vim.api.nvim_create_buf(false, true)
  local ns = vim.api.nvim_create_namespace("command-card-form")

  local win = vim.api.nvim_open_win(bufnr, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = config.get().ui.border,
    title = mode == "add" and " Add Command " or " Edit Command ",
    title_pos = "center",
  })

  vim.bo[bufnr].buftype = "nofile"
  vim.bo[bufnr].bufhidden = "wipe"
  vim.bo[bufnr].swapfile = false
  vim.bo[bufnr].filetype = "command-card-form"
  vim.wo[win].number = false
  vim.wo[win].relativenumber = false
  vim.wo[win].signcolumn = "no"

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines_for(entry, mode))
  add_highlights(bufnr, ns)
  pcall(vim.api.nvim_win_set_cursor, win, { 5, 7 })

  vim.keymap.set("n", "q", function() close(win) end, {
    buffer = bufnr,
    silent = true,
    desc = "Cancel edit",
  })
  vim.keymap.set("n", "<Esc>", function() close(win) end, {
    buffer = bufnr,
    silent = true,
    desc = "Cancel edit",
  })
  vim.keymap.set("n", "s", function()
    local values, err = parse(bufnr)
    if not values then
      util.notify(err, vim.log.levels.WARN)
      return
    end

    local ok, update_err
    if mode == "add" then
      ok, update_err = store.add(values.scope, values, ctx)
    else
      ok, update_err = store.update(entry, values, ctx)
    end
    if not ok then
      util.notify(
        update_err
          or (
            "Failed to "
            .. (mode == "add" and "add" or "update")
            .. " command"
          ),
        vim.log.levels.ERROR
      )
      return
    end

    util.notify(mode == "add" and "Command added" or "Command updated")
    close(win)
    if callback then callback() end
  end, {
    buffer = bufnr,
    silent = true,
    desc = "Save command",
  })
end

function M.add(ctx, callback)
  open_form(default_entry(ctx), ctx, callback, "add")
end

function M.edit(entry, ctx, callback) open_form(entry, ctx, callback, "edit") end

return M
