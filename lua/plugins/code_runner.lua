return {
	"CRAG666/code_runner.nvim",

	config = function()
		require("code_runner").setup({
			mode = "term",

			filetype = {
				python = "python3 -u",

				-- Lua
				lua = "lua",

				-- C
				c = {
					"cd $dir &&",
					"gcc $fileName -o $fileNameWithoutExt.exe &&",
					".\\$fileNameWithoutExt.exe",
				},

				cpp = {
					"cd $dir &&",
					"g++ $fileName -o $fileNameWithoutExt.exe &&",
					".\\$fileNameWithoutExt.exe",
				},
				-- Java
				java = {
					"cd $dir &&",
					"javac $fileName &&",
					"java $fileNameWithoutExt",
				},

				-- Go
				go = "go run",

				-- Bash
				sh = "bash",
			},
		})
	end,

	keys = {
		{
			"<leader>rr",
			"<cmd>RunFile<CR>",
			desc = "Run current file",
		},
		{
			"<leader>rc",
			"<cmd>RunClose<CR>",
			desc = "Close code runner",
		},
	},
}
