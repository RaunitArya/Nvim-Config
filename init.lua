-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- vim.opt.relativenumber = false

-- For sending the deleted files to Recycle Bin
require("config.trash").setup()
