local M = {}

local function json_encode(value)
  if vim.json then return vim.json.encode(value) end
  return vim.fn.json_encode(value)
end

local function json_decode(value)
  if vim.json then return vim.json.decode(value) end
  return vim.fn.json_decode(value)
end

local function is_array(value)
  local max = 0
  local count = 0

  for key, _ in pairs(value) do
    if type(key) ~= "number" or key < 1 or key % 1 ~= 0 then return false end
    max = math.max(max, key)
    count = count + 1
  end

  return max == count
end

local array_keys = {
  commands = true,
  global = true,
  projects = true,
  tags = true,
}

local function empty_table_json(key, parent_key)
  if array_keys[key] or parent_key == "filetypes" then return "[]" end
  return "{}"
end

local function encode_pretty(value, level, current_key, parent_key)
  level = level or 0
  local value_type = type(value)

  if value_type ~= "table" then return json_encode(value) end

  local indent = string.rep("  ", level)
  local child_indent = string.rep("  ", level + 1)

  if vim.tbl_isempty(value) then
    return empty_table_json(current_key, parent_key)
  end

  local lines = {}
  if is_array(value) then
    table.insert(lines, "[")
    for index, item in ipairs(value) do
      local suffix = index < #value and "," or ""
      table.insert(
        lines,
        child_indent
          .. encode_pretty(item, level + 1, nil, current_key)
          .. suffix
      )
    end
    table.insert(lines, indent .. "]")
  else
    local keys = vim.tbl_keys(value)
    table.sort(keys)

    table.insert(lines, "{")
    for index, child_key in ipairs(keys) do
      local suffix = index < #keys and "," or ""
      local encoded_key = json_encode(tostring(child_key))
      local encoded_value =
        encode_pretty(value[child_key], level + 1, child_key, current_key)
      table.insert(
        lines,
        child_indent .. encoded_key .. ": " .. encoded_value .. suffix
      )
    end
    table.insert(lines, indent .. "}")
  end

  return table.concat(lines, "\n")
end

function M.read_json(path)
  if vim.fn.filereadable(path) ~= 1 then return nil end

  local raw = table.concat(vim.fn.readfile(path), "\n")
  if raw == "" then return nil end

  local ok, decoded = pcall(json_decode, raw)
  if not ok then
    M.notify(("Failed to parse %s"):format(path), vim.log.levels.ERROR)
    return nil
  end

  return decoded
end

function M.write_json(path, data)
  vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
  vim.fn.writefile(vim.split(encode_pretty(data), "\n"), path)
end

function M.notify(message, level)
  vim.notify(message, level or vim.log.levels.INFO, { title = "Command Card" })
end

function M.trim(value) return (value or ""):gsub("^%s+", ""):gsub("%s+$", "") end

function M.new_id() return ("%d-%06d"):format(os.time(), math.random(0, 999999)) end

function M.path_join(...)
  local parts = vim.tbl_filter(
    function(part) return part and part ~= "" end,
    { ... }
  )
  return table.concat(parts, "/"):gsub("//+", "/")
end

function M.expand_path(path)
  if not path or path == "" then return nil end
  return vim.fn.fnamemodify(vim.fn.expand(path), ":p")
end

function M.truncate(value, width)
  value = tostring(value or "")
  if width <= 0 then return "" end
  if vim.fn.strdisplaywidth(value) <= width then return value end

  local size = vim.fn.strchars(value)
  while size > 0 do
    local candidate = vim.fn.strcharpart(value, 0, size) .. "..."
    if vim.fn.strdisplaywidth(candidate) <= width then return candidate end
    size = size - 1
  end

  return ""
end

function M.pad(value, width)
  value = M.truncate(value, width)
  local display_width = vim.fn.strdisplaywidth(value)
  if display_width >= width then return value end
  return value .. string.rep(" ", width - display_width)
end

function M.format_time(timestamp)
  return os.date("%Y-%m-%d %H:%M:%S", timestamp or os.time())
end

return M
