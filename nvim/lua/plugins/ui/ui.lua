return {
	{
		"nvim-zh/colorful-winsep.nvim",
		config = true,
		event = { "WinLeave" },
	},
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({
				pre_hook = function()
					vim.opt.eventignore:append({
						"WinScrolled",
						"CursorMoved",
					})
				end,
				post_hook = function()
					vim.opt.eventignore:remove({
						"WinScrolled",
						"CursorMoved",
					})
				end,
			})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup()
		end,
	},
	-- lualine
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup(require("plugins.ui.configs.lualine").configs)
		end,
	},
	-- nvim tree
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<cr>", { silent = true, noremap = true })
			require("nvim-tree").setup({
				on_attach = function(bufnr)
					local api = require("nvim-tree.api")
					local utils = require("helpers.utils")
					local map = require("helpers.keys").lsp_map
					local function edit_or_open()
						local node = api.tree.get_node_under_cursor()

						if node.nodes ~= nil then
							api.node.open.edit()
						else
							api.node.open.edit()
							api.tree.close()
						end
					end

					api.tree.change_root(utils.cached_current_path())
					map("<CR>", edit_or_open, bufnr, "Open file or directory")
					map("a", api.fs.create, bufnr, "Create file")
					map("r", api.fs.rename_sub, bufnr, "Rename file")
					map("c", api.fs.copy.node, bufnr, "Copy file")
					map("d", api.fs.remove, bufnr, "Delete file")
					map("x", api.fs.cut, bufnr, "Cut file")
					map("y", api.fs.paste, bufnr, "Paste file")
					map("?", api.tree.toggle_help, bufnr, "Toggle help")
				end,
			})
		end,
	},
	-- indentline
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		config = function()
			require("ibl").setup()
		end,
	},
	{
		"goolord/alpha-nvim",
		config = function()
			require("alpha").setup(require("plugins.ui.configs.dashboard").config)
		end,
	},
	{
		"onsails/lspkind.nvim",
		init = function()
			require("lspkind").init({
				mode = "symbol_text",
				preset = "codicons",
				symbol_map = {
					Text = "󰉿",
					Method = "󰆧",
					Function = "󰊕",
					Constructor = "",
					Field = "󰜢",
					Variable = "󰀫",
					Class = "󰠱",
					Interface = "",
					Module = "",
					Property = "󰜢",
					Unit = "󰑭",
					Value = "󰎠",
					Enum = "",
					Keyword = "󰌋",
					Snippet = "",
					Color = "󰏘",
					File = "󰈙",
					Reference = "󰈇",
					Folder = "󰉋",
					EnumMember = "",
					Constant = "󰏿",
					Struct = "󰙅",
					Event = "",
					Operator = "󰆕",
					TypeParameter = "",
				},
			})
		end,
	},
}
