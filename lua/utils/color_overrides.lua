local M = {}

function M.setup_colorscheme_overrides()
  local group = vim.api.nvim_create_augroup("ZenThemeHighlights", { clear = true })
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    pattern = "zen*",
    command = "hi Comment gui=NONE | hi Constant gui=NONE",
  })
end

return M
