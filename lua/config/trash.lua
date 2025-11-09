local M = {}

function M.setup()
  -- Trash functionality for sending deleted files to Recycle Bin
  -- You may need to adjust this based on your original setup
  vim.g.netrw_trash_cmd = "Recycle"
end

return M
