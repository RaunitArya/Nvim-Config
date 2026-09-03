return {
	"ryanmsnyder/toggleterm-manager.nvim",

	dependencies = {
		{
			"akinsho/toggleterm.nvim",
			opts = {
				direction = "float",
				shell = "pwsh.exe",
				close_on_exit = false,
			},
		},

		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
	},

	keys = {
		{
			"<leader>ts",
			"<cmd>Telescope toggleterm_manager<CR>",
			mode = "n",
			desc = "Select terminal",
		},
	},

	config = function()
		local manager = require("toggleterm-manager")
		local actions = manager.actions

		manager.setup({
			mappings = {
				i = {
					["<CR>"] = {
						action = actions.toggle_term,
						exit_on_action = true,
					},

					["<C-n>"] = {
						action = actions.create_term,
						exit_on_action = false,
					},

					["<C-r>"] = {
						action = actions.rename_term,
						exit_on_action = false,
					},

					["<C-d>"] = {
						action = actions.delete_term,
						exit_on_action = false,
					},
				},

				n = {
					["<CR>"] = {
						action = actions.toggle_term,
						exit_on_action = true,
					},

					["n"] = {
						action = actions.create_term,
						exit_on_action = false,
					},

					["r"] = {
						action = actions.rename_term,
						exit_on_action = false,
					},

					["d"] = {
						action = actions.delete_term,
						exit_on_action = false,
					},
				},
			},

			results = {
				fields = {
					"state",
					"space",
					"term_icon",
					"term_name",
				},
			},
		})
	end,
}
