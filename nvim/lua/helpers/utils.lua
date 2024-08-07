local M = {}

M.get_config_path = function()
	local os = jit.os
	local config_path = vim.fn.stdpath("config")
	if os == "Linux" then
		return config_path .. "/init.lua"
	elseif os == "Windows" then
		return config_path .. "\\init.lua"
	end
end

M.get_sources_file = function(suffix)
	local f = io.popen("ls", "r")
	if f == nil then
		os.exit(1, true)
	end
	local source = {}
	for line in f:lines() do
		local res = string.match(line, "[a-zA-z0-9]*." .. suffix .. "$")
		if res ~= nil then
			source[#source + 1] = res
		end
	end
	return source
end

---@param input string
---@param delimiter string
---@return string[]
function string.split(input, delimiter)
	input = tostring(input)
	delimiter = tostring(delimiter)
	if delimiter == "" then
		delimiter = " "
	end
	local pos, arr = 0, {}
	-- for each divider found
	for st, sp in
		function()
			return string.find(input, delimiter, pos, true)
		end
	do
		table.insert(arr, string.sub(input, pos, st - 1))
		pos = sp + 1
	end
	table.insert(arr, string.sub(input, pos))
	return arr
end

--- @param bufnr integer
--- @return string
M.get_buffer_path = function(bufnr)
	bufnr = bufnr or 0
	local path = vim.api.nvim_buf_get_name(bufnr)
	return path
end

--- @param path string
--- @param patterns string[]
--- @return string
M.get_current_file_root_path = function(path, patterns)
	if path == "" or path == nil then
		return vim.fn.getcwd()
	end
	local paths = string.split(path, "/")
	local newPaths = {}
	for i = 2, #paths - 1 do
		newPaths[i] = table.concat(paths, "/", 1, i)
	end
	for i = #newPaths, 2, -1 do
		for j = 1, #patterns do
			if vim.fn.filereadable(newPaths[i] .. "/" .. patterns[j]) == 1 then
				return newPaths[i]
			end
		end
	end
	return vim.fn.getcwd()
end

RootPathCache = {}
---cached_get_current_file_root_path
---@return string
M.cached_current_path = function()
	Changed = false
	local ret = vim.fn.getcwd()
	local path = M.get_buffer_path(0)
	path = string.match(path, "(.*/)")
	local patterns = { "Cargo.toml", "go.mod", "Makefile", "CMakeLists.txt", "package.json", "pytprojcet.toml" }
	if path ~= nil then
		if RootPathCache[path] == nil then
			RootPathCache[path] = M.get_current_file_root_path(path, patterns)
		end
		ret = RootPathCache[path]
	end
	return ret
end

-- 定义一个函数用于深拷贝
M.deep_copy = function(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == "table" then
		copy = {}
		for orig_key, orig_value in next, orig, nil do
			copy[M.deep_copy(orig_key)] = M.deep_copy(orig_value)
		end
		setmetatable(copy, M.deep_copy(getmetatable(orig)))
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end

return M
