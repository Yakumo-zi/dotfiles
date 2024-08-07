---@diagnostic disable: need-check-nil

local utils = require("helpers.utils")
local M = {}
M.directory = utils.cached_current_path()
M.excludes = { "CMakeFiles", "src", "include", "third_party", "3rd" }

M.build_with_cmake = function(path)
	local result = io.popen("cd " .. path .. "&&rm -rf " .. path .. "/build" .. "&& cmake -B build && cd build &&make")
	local output = result:read("*a")
	result:close()
	return output
end

M.build_with_make = function(path)
	local result = io.popen("cd " .. path .. "&& make clean && make ")
	local output = result:read("*a")
	result:close()
	return output
end

M.build_with_no_config_file = function(dir)
	local files = vim.split(vim.fn.glob(dir .. "/*"), "\n", { trimempty = true })
	local src = ""
	local is_cpp = false
	for _, file in pairs(files) do
		if vim.fn.isdirectory(file) == 1 then
			goto continue
		end
		if string.match(file, "%.h$") or string.match(file, "%.c$") then
			if string.match(file, "%.hpp$") or string.match(file, "%.cpp$") or string.match(file, "%.cc$") then
				is_cpp = true
			end
			src = src .. " " .. file
		end
		::continue::
	end
	if is_cpp then
		local result = io.popen("g++ -o " .. dir .. "/output" .. src)
		local output = result:read("*a")
		return output
	else
		local result = io.popen("gcc -o " .. dir .. "/output" .. src)
		local output = result:read("*a")
		return output
	end
end

M.check_project_type = function(dir)
	local project_types = { "CMakeLists.txt", "Makefile" }
	local project_type = 0
	local files = vim.split(vim.fn.glob(dir .. "/*"), "\n", { trimempty = true })
	for _, file in pairs(files) do
		for idx, type in ipairs(project_types) do
			if string.find(file, type) then
				project_type = idx
			end
		end
	end
	return project_type
end

M.get_executable_files = function()
	local executable = {}
	local exclude_dirs = M.excludes
	local function traversal_files(dir)
		local files = vim.split(vim.fn.glob(dir .. "/*"), "\n", { trimempty = true })
		for _, file in pairs(files) do
			if vim.fn.isdirectory(file) == 1 then
				for _, exclude in pairs(exclude_dirs) do
					if string.find(file, exclude) then
						goto continue
					end
				end
				traversal_files(file)
				goto continue
			end
			local ft = vim.filetype.match({
				filename = file,
			})
			if ft ~= nil then
				goto continue
			end
			local result = io.popen("file " .. file, "r")
			local output = result:read("*a")
			if string.find(output, "executable") then
				table.insert(executable, file)
			end
			result:close()
			::continue::
		end
	end
	traversal_files(M.directory)
	return executable
end

M.execute_file = function(file)
	local result = io.popen("exec " .. file)
	local output = result:read("*a")
	result:close()
	return output
end

M.compile = function()
	local project_type = M.check_project_type(M.directory)
	local compile_msg = ""
	if project_type == 0 then
		compile_msg = M.build_with_no_config_file(M.directory)
		return
	elseif project_type == 1 then
		compile_msg = M.build_with_cmake(M.directory)
	else
		compile_msg = M.build_with_make(M.directory)
	end
	return compile_msg
end

return M
