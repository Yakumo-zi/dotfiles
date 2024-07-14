return {
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
  {'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
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
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>", "n", desc = "Toogle nvim tree" },
		},
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({})
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
				-- defines how annotations are shown
				-- default: symbol
				-- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
				mode = "symbol_text",

				-- default symbol map
				-- can be either 'default' (requires nerd-fonts font) or
				-- 'codicons' for codicon preset (requires vscode-codicons font)
				--
				-- default: 'default'
				preset = "codicons",

				-- override preset symbols
				--
				-- default: {}
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
