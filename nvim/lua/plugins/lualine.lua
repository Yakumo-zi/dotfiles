return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local colorscheme = require("helpers.colorscheme")
		local lualine_theme = colorscheme == "default" and "auto" or colorscheme
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = lualine_theme,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				-- component_separators = "|",
				-- section_separators = "",
			},
		})
	end,
}
