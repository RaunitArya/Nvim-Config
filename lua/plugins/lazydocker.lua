return {
	{
		"akinsho/toggleterm.nvim",
		opts = {
			shell = "pwsh.exe", -- or full path to PowerShell if needed
		},
		keys = {
			{
				"<leader>ld",
				function()
					local Terminal = require("toggleterm.terminal").Terminal
					local lazydocker = Terminal:new({
						cmd = "lazydocker",
						hidden = true,
						direction = "float",
					})
					lazydocker:toggle()
				end,
				desc = "Toggle Lazydocker",
			},
		},
	},
}
