local config = require("command_card.config")
local util = require("command_card.util")

local M = {}

local uv = vim.uv or vim.loop

local function path_exists(path) return path and uv.fs_stat(path) ~= nil end

local function parent_dir(path)
  local parent = vim.fn.fnamemodify(path, ":h")
  if parent == path then return nil end
  return parent
end

local function find_root_by_markers(start_path, markers)
  local current = start_path

  while current and current ~= "" do
    for _, marker in ipairs(markers or {}) do
      if path_exists(util.path_join(current, marker)) then return current end
    end
    current = parent_dir(current)
  end
end

function M.find_project_root(bufnr)
  local opts = config.get()
  if type(opts.project.root) == "function" then
    local ok, root = pcall(opts.project.root, bufnr)
    if ok and root and root ~= "" then return util.expand_path(root) end
  end

  local name = vim.api.nvim_buf_get_name(bufnr)
  local start_path = name ~= "" and vim.fn.fnamemodify(name, ":p:h")
    or vim.fn.getcwd()

  return find_root_by_markers(start_path, opts.project.root_markers)
    or vim.fn.getcwd()
end

function M.build(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  local filename = vim.api.nvim_buf_get_name(bufnr)
  local project_root = M.find_project_root(bufnr)

  return {
    bufnr = bufnr,
    filetype = vim.bo[bufnr].filetype,
    filename = filename,
    file_dir = filename ~= "" and vim.fn.fnamemodify(filename, ":p:h") or nil,
    cwd = vim.fn.getcwd(),
    project_root = project_root,
    project_name = project_root and vim.fn.fnamemodify(project_root, ":t")
      or nil,
  }
end

function M.project_matches(project, ctx)
  if not project or not project.match or not ctx.project_root then
    return false
  end

  local match = project.match
  if match.type == "root_name" then return ctx.project_name == match.value end

  if match.type == "path_pattern" then
    return ctx.project_root:match(match.value) ~= nil
  end

  if match.type == "marker" then
    return path_exists(util.path_join(ctx.project_root, match.value))
  end

  return false
end

function M.resolve_cwd(command, ctx)
  local cwd = command.cwd or "project"

  if cwd == "project" then return ctx.project_root or ctx.cwd end
  if cwd == "file" then return ctx.file_dir or ctx.cwd end
  if cwd == "nvim" then return ctx.cwd end
  if cwd == "custom" then
    return util.expand_path(command.cwd_path) or ctx.cwd
  end

  return ctx.cwd
end

return M
