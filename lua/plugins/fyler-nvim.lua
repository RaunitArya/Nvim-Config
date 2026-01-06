return {
	"A7Lavinraj/fyler.nvim",
	dependencies = {
		-- "nvim-mini/mini.icons",
		"nvim-tree/nvim-web-devicons",
	},

	keys = {
		{
			"<leader>ee",
			"<cmd>Fyler<CR>",
			desc = "Open Fyler File Explorer",
		},
	},

	opts = {
		hooks = {
			on_delete = nil,
			on_rename = nil,
			on_highlight = nil,
		},

		integrations = {
			icon = "mini_icons",
		},

		--- Override the delete action → send to Recycle Bin
		commands = {
			delete = function(node)
				local path = node.path

				-- Use PowerShell’s Recycle-Item to send file to Recycle Bin
				vim.fn.jobstart({
					"powershell",
					"-NoProfile",
					"-Command",
					"Recycle-Item -Path '" .. path .. "'",
				}, {
					detach = true,
					on_exit = function()
						vim.schedule(function()
							vim.notify("Moved to Recycle Bin: " .. path, vim.log.levels.INFO)
						end)
					end,
				})
			end,
		},

		views = {
			finder = {
				close_on_select = true,
				confirm_simple = false,
				default_explorer = false,

				-- Keep this true, but our custom delete overrides it for Windows
				delete_to_trash = true,

				git_status = {
					enabled = true,
					show_folder_status = true,
					highlight_folders = true,
					symbols = {
						-- Untracked = "?",
						-- Added = "+",
						-- Modified = "*",
						-- Deleted = "x",
						-- Renamed = ">",
						-- Copied = "~",
						-- Conflict = "!",
						-- Ignored = "#",
						--
						Untracked = "?",
						Added = "+",
						Modified = "M",
						Deleted = "D",
						Renamed = "R",
						Copied = "C",
						Conflict = "!",
						Ignored = "#",

						-- 🔥 Folder-level indicators (NEW)
						FolderModified = "M",
						FolderAdded = "A",
						FolderDeleted = "D",
						FolderUntracked = "U",
					},
				},

				icon = {
					-- directory_collapsed = nil,
					-- directory_empty = "",
					-- directory_expanded = "",
					directory_collapsed = " 󰉋",
					directory_expanded = " 󰝰",
					directory_empty = " 󰉖",
				},

				indentscope = {
					enabled = true,
					group = "FylerIndentMarker",
					markers = { { "│", "FylerIndentMarker" } },
				},

				mappings = {
					["q"] = "CloseView",
					["<CR>"] = "Select",
					["<C-t>"] = "SelectTab",
					["|"] = "SelectVSplit",
					["-"] = "SelectSplit",
					["^"] = "GotoParent",
					["="] = "GotoCwd",
					["."] = "GotoNode",
					["#"] = "CollapseAll",
					["<BS>"] = "CollapseNode",
				},

				follow_current_file = true,

				watcher = {
					enabled = false,
				},

				win = {
					border = vim.o.winborder == "" and "single" or vim.o.winborder,
					buf_opts = {
						filetype = "fyler",
						syntax = "fyler",
						buflisted = false,
						buftype = "acwrite",
						expandtab = true,
						shiftwidth = 2,
					},
					kind = "split_left_most",
					kinds = {
						float = {
							height = "70%",
							width = "70%",
							top = "10%",
							left = "15%",
						},
						replace = {},
						split_above = { height = "70%" },
						split_above_all = { height = "70%" },
						split_below = { height = "70%" },
						split_below_all = { height = "70%" },
						split_left = { width = "70%" },
						split_left_most = { width = "30%" },
						split_right = { width = "30%" },
						split_right_most = { width = "30%" },
					},

					win_opts = {
						concealcursor = "nvic",
						conceallevel = 3,
						cursorline = false,
						number = false,
						relativenumber = false,
						winhighlight = "Normal:FylerNormal",
						wrap = false,
					},
				},
			},
		},
	},
}
