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
local inline_diagnostics_enabled = true

local os_name = require("utils").get_os()
if os_name == "windows" then
  opt.shell = "powershell"
else
  opt.shell = "/bin/zsh"
end
opt.shellcmdflag = "-c"
opt.shellquote = ""
opt.shellxquote = ""

local function show_cursor_diagnostics()
  vim.diagnostic.open_float(0, { scope = "cursor" })
end

local function hover_result_has_content(result)
  if not result or not result.contents then
    return false
  end
  local lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
  lines = vim.lsp.util.trim_empty_lines(lines)
  return lines and #lines > 0
end

local function show_hover_doc()
  local bufnr = vim.api.nvim_get_current_buf()
  local has_hover_provider = false

  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    if client.supports_method("textDocument/hover", bufnr) then
      has_hover_provider = true
      break
    end
  end

  if not has_hover_provider then
    vim.notify("No attached LSP supports hover in this buffer", vim.log.levels.WARN)
    return
  end

  local params = vim.lsp.util.make_position_params(0)
  local responses = vim.lsp.buf_request_sync(bufnr, "textDocument/hover", params, 1200) or {}
  for _, response in pairs(responses) do
    if hover_result_has_content(response.result) then
      vim.lsp.buf.hover()
      return
    end
  end

  vim.notify("No hover documentation for symbol under cursor", vim.log.levels.INFO)
end

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
  vim.cmd.source(vim.env.MYVIMRC)
  vim.notify("Config reloaded")
end, { desc = "Reload Neovim config" })

vim.api.nvim_create_user_command("CursorDiagnostics", show_cursor_diagnostics, { desc = "Show diagnostics under cursor" })
vim.api.nvim_create_user_command("HoverDoc", show_hover_doc, { desc = "Show documentation under cursor" })
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
