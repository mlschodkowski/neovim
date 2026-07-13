local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cmdheight = 1
opt.termguicolors = true
opt.scrolloff = 10
opt.signcolumn = "yes"
opt.splitright = true

opt.foldmethod = "manual"
opt.foldenable = false

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.ignorecase = true
opt.smartcase = true
opt.completeopt = "menuone,noselect"
opt.exrc = true

opt.fillchars = {
  vert = " ",
  horiz = " ",
  horizup = " ",
  horizdown = " ",
  vertleft = " ",
  vertright = " ",
  verthoriz = " ",
}
opt.guicursor = "n-v-c:block-blinkon1-CursorInsert,i:block-CursorInsert"

vim.g.zig_fmt_parse_errors = 0
vim.g.disable_autoformat = true

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  severity_sort = true,
})
local inline_diagnostics_enabled = false

local os_name = require("utils").get_os()
if os_name == "windows" then
  opt.shell = "powershell"
else
  opt.shell = "/bin/zsh"
end
opt.shellcmdflag = "-c"
opt.shellquote = ""
opt.shellxquote = ""

local function toggle_inline_diagnostics()
  inline_diagnostics_enabled = not inline_diagnostics_enabled
  vim.diagnostic.config({
    virtual_text = inline_diagnostics_enabled,
  })
  vim.notify(
    "Inline diagnostics " .. (inline_diagnostics_enabled and "enabled" or "disabled"),
    vim.log.levels.INFO
  )
end

vim.api.nvim_create_user_command("Setwd", function()
  vim.cmd.cd(vim.fn.expand("%:p:h"))
end, { desc = "Set cwd to current file directory" })

vim.api.nvim_create_user_command("ConfigOpen", function()
  vim.cmd.edit(vim.fn.stdpath("config") .. "/init.lua")
end, { desc = "Open Neovim config" })

vim.api.nvim_create_user_command("ConfigReload", function()
  for name in pairs(package.loaded) do
    if name:match("^utils") or name == "options" or name == "keymaps" or name == "custom_filetypes" or name == "autocmds" or name == "macros" then
      package.loaded[name] = nil
    end
  end
  vim.cmd.source(vim.env.MYVIMRC)
  vim.notify("Core config reloaded. Restart Neovim after plugin-spec changes.")
end, { desc = "Reload core Neovim config" })

vim.api.nvim_create_user_command("ToggleInlineDiagnostics", toggle_inline_diagnostics, { desc = "Toggle inline diagnostics" })

vim.api.nvim_create_user_command("FormatDisable", function()
  vim.g.disable_autoformat = true
end, { desc = "Disable autoformat on save" })

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.g.disable_autoformat = false
end, { desc = "Enable autoformat on save" })

vim.api.nvim_create_user_command("ToggleInlineBlame", function()
  require("gitsigns").toggle_current_line_blame()
end, { desc = "Toggle inline git blame" })

vim.api.nvim_create_user_command("ThemeDarkAf", function()
  vim.cmd("DarkAf")
end, { desc = "Set colorscheme to dark_af" })
