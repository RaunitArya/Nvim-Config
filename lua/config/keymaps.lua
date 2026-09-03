-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Remove LazyVim's default terminal mappings
pcall(vim.keymap.del, "n", "<C-/>")
pcall(vim.keymap.del, "t", "<C-/>")
pcall(vim.keymap.del, "n", "<C-_>")
pcall(vim.keymap.del, "t", "<C-_>")

-- -- -- ToggleTerm
local function toggle_terminal()
	local toggleterm = require("toggleterm")

	-- If we're currently inside a ToggleTerm terminal,
	-- toggle that exact terminal.
	if vim.bo.filetype == "toggleterm" then
		local terminal_id = vim.b.toggle_number

		if terminal_id then
			toggleterm.toggle(terminal_id)
			return
		end
	end

	-- Otherwise toggle the default/last terminal.
	toggleterm.toggle()
end

vim.keymap.set({ "n", "t" }, "<C-/>", toggle_terminal, {
	desc = "Toggle terminal",
})

vim.keymap.set({ "n", "t" }, "<C-_>", toggle_terminal, {
	desc = "Toggle terminal",
})
