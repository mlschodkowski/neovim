local utils = require("utils")

-- Keep startup consistent when opening directories (use Telescope flow, not netrw explorer).
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- stop annoying deprecation errors that i cant control
-- because i dont have access to the plugins that use
-- the deprecated functions
vim.deprecate = function() end

require("options")
require("keymaps")
require("custom_filetypes")
require("lazynvim")
require("autocmds")

utils.color_overrides.setup_colorscheme_overrides()
utils.theme.apply_saved_or_default("poimandres")

utils.fix_telescope_parens_win()
utils.dashboard.setup_dashboard_image_colors()

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if #vim.api.nvim_list_uis() == 0 then
      return
    end
    if vim.fn.argc() ~= 1 then
      return
    end
    local arg = vim.fn.argv(0)
    if vim.fn.isdirectory(arg) == 0 then
      return
    end
    vim.cmd.cd(arg)
    vim.cmd.enew()
    vim.schedule(function()
      require("telescope.builtin").find_files({ cwd = arg })
    end)
  end,
})
