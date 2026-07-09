local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cmdheight = 0
opt.termguicolors = true
opt.scrolloff = 10
opt.signcolumn = "no"
opt.splitright = true

opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldnestmax = 1
opt.foldopen:remove("hor")

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.ignorecase = true
opt.completeopt = "menuone,noselect,preview"
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
vim.g.disable_autoformat = vim.g.disable_autoformat or false

vim.diagnostic.config({
  virtual_text = true,
})

local os_name = require("utils").get_os()
if os_name == "windows" then
  opt.shell = "powershell"
else
  opt.shell = "/bin/zsh"
end
opt.shellcmdflag = "-c"
opt.shellquote = ""
opt.shellxquote = ""

local function open_in_obsidian()
  local file = vim.fn.expand("%:p")
  if not file:match("%.md$") then
    vim.cmd("silent edit " .. vim.fn.fnameescape(file))
    return
  end

  local vault = "notes"
  local vault_path = vim.fn.expand("~/notes")
  local relative_path = file:gsub(vault_path, "")
  local url = "obsidian://open?vault=" .. vault .. "&file=" .. vim.fn.fnameescape(relative_path)
  if os_name == "mac" then
    vim.fn.system({ "open", url })
  else
    vim.fn.system({ "xdg-open", url })
  end
end

vim.api.nvim_create_user_command("Setwd", function()
  vim.cmd.cd(vim.fn.expand("%:p:h"))
end, { desc = "Set cwd to current file directory" })

vim.api.nvim_create_user_command("ConfigOpen", function()
  vim.cmd.edit(vim.fn.stdpath("config") .. "/init.lua")
end, { desc = "Open Neovim config" })

vim.api.nvim_create_user_command("ConfigReload", function()
  vim.cmd.source(vim.env.MYVIMRC)
  vim.notify("Config reloaded")
end, { desc = "Reload Neovim config" })

vim.api.nvim_create_user_command("OpenInObsidian", open_in_obsidian, { desc = "Open current markdown file in Obsidian" })

vim.api.nvim_create_user_command("FormatDisable", function()
  vim.g.disable_autoformat = true
end, { desc = "Disable autoformat on save" })

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.g.disable_autoformat = false
end, { desc = "Enable autoformat on save" })

vim.api.nvim_create_user_command("ToggleInlineBlame", function()
  vim.cmd("Gitsigns toggle_current_line_blame")
end, { desc = "Toggle inline git blame" })

vim.api.nvim_create_user_command("ThemeDarkAf", function()
  vim.cmd("DarkAf")
end, { desc = "Set colorscheme to dark_af" })
