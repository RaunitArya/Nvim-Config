return {
	-- Go LSP via gopls
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				gopls = {
					settings = {
						gopls = {
							analyses = {
								unusedparams = true,
								shadow = true,
							},
							staticcheck = true,
						},
					},
				},
			},
		},
	},

	-- Formatter (goimports)
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				go = { "goimports" },
			},
		},
	},

	-- Go tools (run, build, test, etc.)
	{
		"ray-x/go.nvim",
		dependencies = { "ray-x/guihua.lua" },
		config = function()
			require("go").setup()
		end,
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()',
	},

	-- Debugging with delve
	{
		"mfussenegger/nvim-dap",
		dependencies = { "leoluz/nvim-dap-go" },
		config = function()
			require("dap-go").setup()
		end,
	},
}
