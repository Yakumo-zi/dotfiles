local M = {}
local map = require("helpers.keys").lsp_map
local runner = require("test.cpp_runner")

-- 创建浮动窗口并返回缓冲区和窗口ID
local function create_floating_window(offset)
	local loffset = offset or 0
	-- 获取当前窗口的大小
	local width = vim.api.nvim_get_option("columns")
	local height = vim.api.nvim_get_option("lines")

	-- 定义浮动窗口的宽度和高度
	local win_width = 60
	local win_height = 25

	-- 计算浮动窗口的位置
	local row = math.floor((height - win_height) / 2)
	local col = math.floor((width - win_width) / 2) + loffset

	-- 创建一个新的缓冲区
	local buf = vim.api.nvim_create_buf(false, true)

	-- 创建浮动窗口
	local opts = {
		style = "minimal",
		relative = "editor",
		width = win_width,
		height = win_height,
		row = row,
		col = col,
		border = "rounded",
	}
	local win = vim.api.nvim_open_win(buf, true, opts)
	vim.api.nvim_buf_set_option(buf, "wrap", true)
	vim.api.nvim_buf_set_option(buf, "linebreak", true)
	return buf, win
end

-- 更新浮动窗口内容
local function update_floating_window(buf, content)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
end

local function create_floating_menu(items, select_action, offset)
	local loffset = offset or 0
	-- 获取当前窗口的大小
	local width = vim.api.nvim_get_option("columns")
	local height = vim.api.nvim_get_option("lines")

	-- 定义浮动窗口的宽度和高度
	local win_width = 25
	local win_height = 25

	-- 计算浮动窗口的位置
	local row = math.floor((height - win_height) / 2)
	local col = math.floor((width - win_width) / 2) + loffset

	-- 创建一个缓冲区
	local buf = vim.api.nvim_create_buf(false, true)

	-- 设置缓冲区的内容
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, items)

	-- 创建浮动窗口
	local opts = {
		style = "minimal",
		relative = "editor",
		width = win_width,
		height = win_height,
		row = row,
		col = col,
		border = "rounded",
	}
	local win = vim.api.nvim_open_win(buf, true, opts)

	local function select_menu_item()
		local line = vim.fn.line(".")
		select_action(line)
	end

	map("<cr>", select_menu_item, buf)
	vim.api.nvim_buf_set_option(buf, "wrap", true)
	vim.api.nvim_buf_set_option(buf, "linebreak", true)
	return buf, win
end
M.run = function()
	local executables = {}
	local executable_names = {}
	for _, path in pairs(runner.get_executable_files()) do
		local segs = string.split(path, "/")
		local name = segs[#segs]
		table.insert(executable_names, name)
		executables[name] = path
	end

	local tbuf, _ = create_floating_window(20)
	local buf, _ = create_floating_menu(executable_names, function(idx)
		local filepath = executables[executable_names[idx]]
		local res = runner.execute_file(filepath)
		local segs = string.split(res, "\n")
		update_floating_window(tbuf, segs)
	end, -25)

	local function close_window()
		vim.api.nvim_buf_delete(buf, { unload = true })
		vim.api.nvim_buf_delete(tbuf, { unload = true })
	end

	map("<Esc>", close_window, buf)
	map("Q", close_window, buf)
end
M.compile = function()
	local tbuf, _ = create_floating_window()
	local res = runner.compile()
	local segs = string.split(res, "\n")
	update_floating_window(tbuf, segs)
	map("<Esc>", "<cmd>bd!<cr>", tbuf)
	map("Q", "<cmd>bd!<cr>", tbuf)
end
return M
