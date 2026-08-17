return {
	{
		"stevearc/oil.nvim",
		lazy = false,

		dependencies = {
			{ "nvim-mini/mini.icons", opts = {} },
		},

		keys = {
			{
				"<leader>ee",
				"<cmd>Oil<cr>",
				desc = "Open Oil",
			},
		},

		opts = {
			default_file_explorer = true,
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,

			---------------------------------------------------------------------------
			-- Keymaps
			---------------------------------------------------------------------------

			use_default_keymaps = false,

			keymaps = {
				---------------------------------------------------------------------------
				-- Core hjkl navigation
				---------------------------------------------------------------------------

				["h"] = {
					"actions.parent",
					mode = "n",
					desc = "Go to parent directory",
				},

				["l"] = {
					"actions.select",
					mode = "n",
					desc = "Open file / enter directory",
				},

				-- j/k are intentionally not mapped.
				-- They are normal Neovim cursor movement.

				---------------------------------------------------------------------------
				-- Close
				---------------------------------------------------------------------------

				["q"] = {
					"actions.close",
					mode = "n",
					desc = "Close Oil",
				},

				["<Esc>"] = {
					"actions.close",
					mode = "n",
					desc = "Close Oil",
				},

				---------------------------------------------------------------------------
				-- Open in different windows
				---------------------------------------------------------------------------

				["s"] = {
					"actions.select",
					opts = {
						horizontal = true,
					},
					mode = "n",
					desc = "Open in horizontal split",
				},

				["v"] = {
					"actions.select",
					opts = {
						vertical = true,
					},
					mode = "n",
					desc = "Open in vertical split",
				},

				["t"] = {
					"actions.select",
					opts = {
						tab = true,
					},
					mode = "n",
					desc = "Open in new tab",
				},

				---------------------------------------------------------------------------
				-- Preview
				---------------------------------------------------------------------------

				["p"] = {
					"actions.preview",
					mode = "n",
					desc = "Preview",
				},

				---------------------------------------------------------------------------
				-- Navigation
				---------------------------------------------------------------------------

				["H"] = {
					"actions.open_cwd",
					mode = "n",
					desc = "Go to working directory",
				},

				["~"] = {
					"actions.cd",
					opts = {
						scope = "tab",
					},
					mode = "n",
					desc = "Change tab directory",
				},

				---------------------------------------------------------------------------
				-- Refresh / hidden files
				---------------------------------------------------------------------------

				["r"] = {
					"actions.refresh",
					mode = "n",
					desc = "Refresh",
				},

				["."] = {
					"actions.toggle_hidden",
					mode = "n",
					desc = "Toggle hidden files",
				},

				---------------------------------------------------------------------------
				-- Sorting
				---------------------------------------------------------------------------

				["o"] = {
					"actions.change_sort",
					mode = "n",
					desc = "Change sort",
				},

				---------------------------------------------------------------------------
				-- External application
				---------------------------------------------------------------------------

				["gx"] = {
					"actions.open_external",
					mode = "n",
					desc = "Open externally",
				},

				---------------------------------------------------------------------------
				-- Trash
				---------------------------------------------------------------------------

				["gt"] = {
					"actions.toggle_trash",
					mode = "n",
					desc = "Toggle trash",
				},

				---------------------------------------------------------------------------
				-- Help
				---------------------------------------------------------------------------

				["?"] = {
					"actions.show_help",
					mode = "n",
					desc = "Show Oil help",
				},
			},

			---------------------------------------------------------------------------
			-- Appearance
			---------------------------------------------------------------------------

			columns = {
				"icon",
			},

			win_options = {
				wrap = false,
				signcolumn = "no",
				cursorcolumn = false,
				foldcolumn = "0",
				spell = false,
				list = false,
				conceallevel = 3,
				concealcursor = "nvic",
			},

			view_options = {
				show_hidden = false,
				natural_order = "fast",
				case_insensitive = false,

				sort = {
					{ "type", "asc" },
					{ "name", "asc" },
				},
			},

			float = {
				padding = 2,
				max_width = 0.8,
				max_height = 0.8,
				border = "rounded",

				win_options = {
					winblend = 0,
				},

				preview_split = "auto",
			},

			preview_win = {
				update_on_cursor_moved = true,
				preview_method = "fast_scratch",
			},
		},
	},

	{
		"malewicz1337/oil-git.nvim",
		dependencies = {
			"stevearc/oil.nvim",
		},
	},
}
