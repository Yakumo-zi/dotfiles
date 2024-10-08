return {
	{
		"folke/tokyonight.nvim",
		lazy = true,
	},
	{
		"navarasu/onedark.nvim",
		lazy = true,
	},
	{
		"catppuccin/nvim",
		-- lazy = true,
		name = "catppuccin",
		priority = 1000,
		config = function()
			--- @type CatppuccinOptions
			local opt = {
				term_colors = true,
				no_italic = true,
				transparent_background = true,
				flavour = "latte", -- latte, frappe, macchiato, mocha
				integrations = {
					barbar = true,
					alpha = true,
					cmp = true,
					dashboard = true,
					flash = true,
					fidget = true,
					gitsigns = true,
					illuminate = true,
					indent_blankline = { enabled = true },
					lsp_trouble = true,
					mason = true,
					markdown = true,
					mini = true,
					native_lsp = {
						enabled = true,
						underlines = {
							errors = { "undercurl" },
							hints = { "undercurl" },
							warnings = { "undercurl" },
							information = { "undercurl" },
						},
					},
					notify = true,
					telescope = {
						enabled = true,
					},
					treesitter = true,
					treesitter_context = true,
					which_key = true,
					nvim_surround = true,
					ufo = true,
					symbols_outline = true,
				},
			}
			vim.api.nvim_set_hl(0, "FidgetTitle", { link = "NormalFloat" })
			vim.api.nvim_set_hl(0, "FidgetTask", { link = "NormalFloat" })
			require("catppuccin").setup(opt)
			vim.cmd.colorscheme("catppuccin")
			require("lspconfig.ui.windows").default_options.border = "rounded"
		end,
	},
	{
		"sainnhe/everforest",
		lazy = true,
		priority = 1000,
		config = function()
			vim.g.everforest_diagnostic_line_highlight = 1
			vim.cmd.colorscheme("everforest")
		end,
	},
}
