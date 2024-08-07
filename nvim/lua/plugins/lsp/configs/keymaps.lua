local M = {}
M.on_attach = function(_, bufnr)
	local buf_map = require("helpers.keys").lsp_map
	local map = require("helpers.keys").map

	local jump_to_file = function()
		local filename = vim.api.nvim_buf_get_name(0)
		local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
		require("goto-preview").close_all_win()
		vim.cmd("edit " .. filename)
		vim.api.nvim_win_set_cursor(0, { cursor_line, 0 })
	end

	buf_map("<leader>fm", "<cmd>Format<CR>", bufnr, "Format current buf")
	buf_map("<leader>rn", ":IncRename ", bufnr, "Rename symbol")
	buf_map("<leader>so", "<cmd>Outline<CR>", bufnr, "Toggle Outline")
	buf_map("gd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", bufnr, "Go to preview definition")
	buf_map(
		"gi",
		"<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
		bufnr,
		"Go to preview definition"
	)
	buf_map("gr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", bufnr, "Go to preview definition")
	buf_map("gD", "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>", bufnr, "Go to preview definition")
	buf_map("q", "<cmd>lua require('goto-preview').close_all_win()<CR>", bufnr, "Go to preview definition")
	map({ "n" }, "<C-c>o", jump_to_file, "Jump to goal file")
end
M.auto_cmp = function(cmp, luasnip)
	return cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	})
end
return M
