local config = require("command_card.config")
local context = require("command_card.context")
local util = require("command_card.util")

local M = {}

local cache

local function empty_data()
  return {
    version = 1,
    global = {},
    filetypes = {},
    projects = {},
  }
end

local function normalize(data)
  data = type(data) == "table" and data or empty_data()
  data.version = 1
  data.global = type(data.global) == "table" and data.global or {}
  data.filetypes = type(data.filetypes) == "table" and data.filetypes or {}
  data.projects = type(data.projects) == "table" and data.projects or {}
  return data
end

local function prepare_command(command)
  command.id = command.id or util.new_id()
  command.name = util.trim(command.name)
  command.cmd = util.trim(command.cmd)
  command.cwd = command.cwd or "project"
  if command.cwd ~= "custom" then command.cwd_path = nil end
  command.description = command.description or ""
  command.tags = type(command.tags) == "table" and command.tags or {}
  command.created_at = command.created_at or os.time()
  command.updated_at = os.time()
  return command
end

local function ensure_project(data, ctx)
  local name = ctx.project_name
    or vim.fn.fnamemodify(ctx.project_root or ctx.cwd, ":t")

  for _, project in ipairs(data.projects) do
    if
      project.match
      and project.match.type == "root_name"
      and project.match.value == name
    then
      project.commands = type(project.commands) == "table" and project.commands
        or {}
      return project
    end
  end

  local project = {
    name = name,
    match = {
      type = "root_name",
      value = name,
    },
    commands = {},
  }
  table.insert(data.projects, project)
  return project
end

local function remove_from(list, entry)
  for index, command in ipairs(list or {}) do
    if command.id == entry.command.id or index == entry.command_index then
      table.remove(list, index)
      return true
    end
  end
  return false
end

local function find_command(list, entry)
  for index, command in ipairs(list or {}) do
    if command.id == entry.command.id or index == entry.command_index then
      return command
    end
  end
end

local function validate_target(scope, command, ctx)
  if command.name == "" or command.cmd == "" then
    return false, "Command name and command body are required"
  end
  if scope == "filetype" and (not ctx.filetype or ctx.filetype == "") then
    return false, "Current buffer has no filetype"
  end
  if
    scope == "project"
    and not (ctx.project_name or ctx.project_root or ctx.cwd)
  then
    return false, "Current project could not be resolved"
  end
  if scope ~= "global" and scope ~= "filetype" and scope ~= "project" then
    return false, "Unknown command scope: " .. tostring(scope)
  end
  return true
end

local function insert_command(data, scope, command, ctx)
  if scope == "global" then
    table.insert(data.global, command)
  elseif scope == "filetype" then
    data.filetypes[ctx.filetype] = data.filetypes[ctx.filetype] or {}
    table.insert(data.filetypes[ctx.filetype], command)
  elseif scope == "project" then
    local project = ensure_project(data, ctx)
    table.insert(project.commands, command)
  end
end

function M.load(force)
  if cache and not force then return cache end

  cache = normalize(util.read_json(config.get().storage.path))
  return cache
end

function M.reload() return M.load(true) end

function M.save(data)
  cache = normalize(data or cache)
  util.write_json(config.get().storage.path, cache)
end

function M.list(ctx)
  local data = M.load()
  local items = {}

  local function append(scope, source, commands, meta)
    for index, command in ipairs(commands or {}) do
      if command.name and command.cmd then
        table.insert(
          items,
          vim.tbl_extend("force", meta or {}, {
            scope = scope,
            source = source,
            source_label = source,
            command = command,
            command_index = index,
          })
        )
      end
    end
  end

  append("global", "global", data.global)

  if ctx.filetype and ctx.filetype ~= "" then
    append(
      "filetype",
      "filetype:" .. ctx.filetype,
      data.filetypes[ctx.filetype],
      {
        filetype = ctx.filetype,
      }
    )
  end

  for project_index, project in ipairs(data.projects) do
    if context.project_matches(project, ctx) then
      append(
        "project",
        "project:" .. (project.name or ctx.project_name),
        project.commands,
        {
          project_index = project_index,
        }
      )
    end
  end

  return items
end

function M.add(scope, command, ctx)
  local data = M.load()
  command = prepare_command(command)

  local ok, err = validate_target(scope, command, ctx)
  if not ok then return false, err end

  insert_command(data, scope, command, ctx)
  M.save(data)
  return true
end

function M.delete(entry)
  local data = M.load()
  local ok = false

  if entry.scope == "global" then
    ok = remove_from(data.global, entry)
  elseif entry.scope == "filetype" and entry.filetype then
    ok = remove_from(data.filetypes[entry.filetype], entry)
  elseif entry.scope == "project" and entry.project_index then
    local project = data.projects[entry.project_index]
    ok = project and remove_from(project.commands, entry)
  end

  if ok then M.save(data) end
  return ok
end

function M.update(entry, values, ctx)
  local data = M.load()
  local command
  local scope = values.scope or entry.scope

  if entry.scope == "global" then
    command = find_command(data.global, entry)
  elseif entry.scope == "filetype" and entry.filetype then
    command = find_command(data.filetypes[entry.filetype], entry)
  elseif entry.scope == "project" and entry.project_index then
    local project = data.projects[entry.project_index]
    command = project and find_command(project.commands, entry)
  end

  if not command then return false end

  local updated = vim.deepcopy(command)
  updated.name = util.trim(values.name)
  updated.cmd = util.trim(values.cmd)
  updated.cwd = values.cwd
  updated.cwd_path = values.cwd == "custom" and values.cwd_path or nil
  updated.description = values.description or ""
  updated.tags = type(values.tags) == "table" and values.tags or {}
  updated.updated_at = os.time()

  local ok, err = validate_target(scope, updated, ctx or {})
  if not ok then return false, err end

  if scope ~= entry.scope then
    if not M.delete(entry) then return false, "Failed to move command" end
    data = M.load()
    insert_command(data, scope, updated, ctx or {})
  else
    command.name = updated.name
    command.cmd = updated.cmd
    command.cwd = updated.cwd
    command.cwd_path = updated.cwd_path
    command.description = updated.description
    command.tags = updated.tags
    command.updated_at = updated.updated_at
  end

  M.save(data)
  return true
end

return M
