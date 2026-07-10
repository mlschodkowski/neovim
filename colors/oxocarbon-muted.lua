-- Oxocarbon with quieter accents and a transparent editor canvas.
-- The background is intentionally left to Ghostty's opacity and blur.
local ok = pcall(vim.cmd.colorscheme, "oxocarbon")
if not ok then
  return
end

local hl = vim.api.nvim_set_hl
local none = "NONE"

for _, group in ipairs({
  "Normal", "NormalNC", "NormalFloat", "SignColumn", "FoldColumn", "EndOfBuffer",
  "LineNr", "VertSplit", "WinSeparator", "ColorColumn", "CursorLine", "CursorColumn",
  "Folded", "Pmenu", "PmenuSbar", "LspCodeLens", "LspReferenceText", "LspReferenceRead",
  "LspReferenceWrite",
}) do
  hl(0, group, { bg = none })
end

local muted = {
  Comment = { fg = "#7785a3", italic = false },
  Constant = { fg = "#aa9bd4" },
  String = { fg = "#70c6b5" },
  Character = { fg = "#70c6b5" },
  Number = { fg = "#b39ddd" },
  Boolean = { fg = "#b39ddd" },
  Float = { fg = "#b39ddd" },
  Function = { fg = "#69b9d0" },
  Identifier = { fg = "#c0c9e4" },
  Statement = { fg = "#aaa4d5" },
  Keyword = { fg = "#aaa4d5" },
  Type = { fg = "#7fc5a1" },
  Special = { fg = "#c09ac5" },
  Operator = { fg = "#9bb6d6" },
  PreProc = { fg = "#b59dcc" },
  Error = { fg = "#d17d9e", bg = none },
  DiagnosticError = { fg = "#d17d9e", bg = none },
  DiagnosticWarn = { fg = "#d0b66f", bg = none },
  DiagnosticInfo = { fg = "#69b9d0", bg = none },
  DiagnosticHint = { fg = "#7fc5a1", bg = none },
  Search = { fg = "#161616", bg = "#c09ac5" },
  IncSearch = { fg = "#161616", bg = "#d0b66f" },
  Visual = { bg = "#292d4a" },
  CursorLineNr = { fg = "#c09ac5", bg = none },
  PmenuSel = { fg = "#161616", bg = "#69b9d0" },
}

for group, opts in pairs(muted) do
  hl(0, group, opts)
end

vim.g.colors_name = "oxocarbon-muted"
