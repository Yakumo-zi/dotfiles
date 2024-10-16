-- 功能插件汇总
return {
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		opts = {},
	},
	{
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
		lazy = false,
	},
	{
		{
			"akinsho/toggleterm.nvim",
			version = "*",
			opts = {
				float_opts = {
					border = "curved",
				},
				autochdir = true,
			},
		},
	},
	{
		"folke/which-key.nvim",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify")
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({})
			require("telescope").load_extension("projects")
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({})
		end,
	},
	{
		"dzfrias/arena.nvim",
		event = "BufWinEnter",
		config = true,
	},
}
