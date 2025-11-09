return {
	-- Python LSP configuration
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				pyright = {
					settings = {
						python = {
							analysis = {
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
								diagnosticMode = "workspace",
							},
						},
					},
				},
			},
		},
	},
	-- Python debugging
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"mason-org/mason.nvim",
		},
		config = function()
			local ok, mason_registry = pcall(require, "mason-registry")
			if ok and mason_registry.is_installed("debugpy") then
				local debugpy = mason_registry.get_package("debugpy")
				local install_path = debugpy:get_install_path()
				require("dap-python").setup(install_path .. "/venv/Scripts/python.exe")
			else
				-- Fallback to system python
				require("dap-python").setup("python")
			end
		end,
	},
}
