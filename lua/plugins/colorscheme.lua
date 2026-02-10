return {
	{
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			require("onedark").setup({
				style = "darker",

				transparent = true,

				lualine = {
					transparent = true,
				},

				--  Custom highlight overrides for floats & sidebars
				highlights = {
					Normal = { bg = "none" },
					NormalNC = { bg = "none" },
					NormalFloat = { bg = "none" },
					FloatBorder = { bg = "none" },
					FloatTitle = { bg = "none" },
					SignColumn = { bg = "none" },
					StatusLine = { bg = "none" },
					StatusLineNC = { bg = "none" },
					TabLineFill = { bg = "none" },
					NeoTreeNormal = { bg = "none" },
					NeoTreeNormalNC = { bg = "none" },
					Pmenu = { bg = "none" }, -- completion menu
					PmenuSel = { bg = "none" },
					PmenuSbar = { bg = "none" },
					PmenuThumb = { bg = "none" },
				},
			})

			require("onedark").load()
		end,
	},

	{ "projekt0n/github-nvim-theme", name = "github-theme" },

	-- LazyVim selects the theme
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "onedark",
		},
	},
}
