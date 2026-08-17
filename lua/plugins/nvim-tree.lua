return {
	"nvim-tree/nvim-tree.lua",
	enabled = true,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"nvim-mini/mini.icons",
	},
	config = function()
		local nvimtree = require("nvim-tree")
		local api = require("nvim-tree.api")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		---------------------------------------------------------------------------
		-- Send file/folder to Windows Recycle Bin
		---------------------------------------------------------------------------
		local function recycle_node()
			local node = api.tree.get_node_under_cursor()

			if not node or not node.absolute_path then
				vim.notify("No file or folder selected", vim.log.levels.WARN)
				return
			end

			local path = node.absolute_path
			local name = vim.fn.fnamemodify(path, ":t")

			-- Ask for confirmation
			local choice = vim.fn.confirm("Move '" .. name .. "' to the Recycle Bin?", "&Yes\n&No", 2)

			-- User selected No / closed the dialog
			if choice ~= 1 then
				return
			end

			-- Escape single quotes for PowerShell
			local escaped_path = path:gsub("'", "''")

			local ps_command

			if node.type == "directory" then
				ps_command = string.format(
					[[Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteDirectory('%s', 'OnlyErrorDialogs', 'SendToRecycleBin')]],
					escaped_path
				)
			else
				ps_command = string.format(
					[[Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile('%s', 'OnlyErrorDialogs', 'SendToRecycleBin')]],
					escaped_path
				)
			end

			local result = vim.fn.system({
				"powershell.exe",
				"-NoProfile",
				"-NonInteractive",
				"-Command",
				ps_command,
			})

			if vim.v.shell_error == 0 then
				vim.notify("Moved to Recycle Bin: " .. name, vim.log.levels.INFO)
				api.tree.reload()
			else
				vim.notify("Failed to move to Recycle Bin: " .. result, vim.log.levels.ERROR)
			end
		end

		---------------------------------------------------------------------------
		-- Permanently delete file/folder
		---------------------------------------------------------------------------
		local function permanent_delete()
			local node = api.tree.get_node_under_cursor()

			if not node or not node.absolute_path then
				vim.notify("No file or folder selected", vim.log.levels.WARN)
				return
			end

			local path = node.absolute_path
			local name = vim.fn.fnamemodify(path, ":t")

			-- Stronger confirmation for permanent deletion
			local choice =
				vim.fn.confirm("PERMANENTLY delete '" .. name .. "'?\nThis cannot be undone!", "&Yes\n&No", 2)

			if choice ~= 1 then
				return
			end

			-- Escape single quotes for PowerShell
			local escaped_path = path:gsub("'", "''")

			local ps_command = string.format([[Remove-Item -LiteralPath '%s' -Recurse -Force]], escaped_path)

			local result = vim.fn.system({
				"powershell.exe",
				"-NoProfile",
				"-NonInteractive",
				"-Command",
				ps_command,
			})

			if vim.v.shell_error == 0 then
				vim.notify("Permanently deleted: " .. name, vim.log.levels.WARN)
				api.tree.reload()
			else
				vim.notify("Failed to permanently delete: " .. result, vim.log.levels.ERROR)
			end
		end

		---------------------------------------------------------------------------
		-- nvim-tree keymaps
		---------------------------------------------------------------------------
		local function on_attach(bufnr)
			local function opts(desc)
				return {
					desc = "nvim-tree: " .. desc,
					buffer = bufnr,
					noremap = true,
					silent = true,
					nowait = true,
				}
			end

			-- Load nvim-tree's default keymaps
			api.map.on_attach.default(bufnr)

			-- d = Recycle Bin
			vim.keymap.set("n", "d", recycle_node, opts("Move to Recycle Bin"))
			-- D = Permanent delete
			vim.keymap.set("n", "D", permanent_delete, opts("Permanently Delete"))
		end

		nvimtree.setup({
			on_attach = on_attach,

			view = {
				width = 50,
				relativenumber = true,
			},

			renderer = {
				indent_markers = {
					enable = false,
				},

				icons = {
					web_devicons = {
						file = {
							enable = true,
							color = true,
						},
						folder = {
							enable = false,
							color = true,
						},
					},

					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
					},

					glyphs = {
						default = "●",
						symlink = "",
						bookmark = "󰆤",
						modified = "●",

						folder = {
							arrow_closed = "",
							arrow_open = "",
							default = "󰉋",
							open = "󰝰",
							empty = "󰉖",
							empty_open = "󰷏",
							symlink = "",
							symlink_open = "",
						},

						git = {
							unstaged = "✗",
							staged = "✓",
							unmerged = "",
							renamed = "➜",
							untracked = "★",
							deleted = "",
							ignored = "◌",
						},
					},
				},
			},

			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},

			filters = {
				custom = { ".DS_Store" },
			},

			git = {
				ignore = false,
			},
		})

		---------------------------------------------------------------------------
		-- Global keymaps
		---------------------------------------------------------------------------
		local keymap = vim.keymap

		keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })

		keymap.set(
			"n",
			"<leader>ef",
			"<cmd>NvimTreeFindFileToggle<CR>",
			{ desc = "Toggle file explorer on current file" }
		)

		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })

		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
	end,
}
