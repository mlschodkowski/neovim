-- Kanagawa Wave with a deliberately small syntax palette.
if not pcall(vim.cmd.colorscheme, "kanagawa-wave") then
  return
end

local hl = vim.api.nvim_set_hl
local colors = {
  bg = "#1f1f28",
  fg = "#dcd7ba",
  muted = "#727169",
  blue = "#7e9cd8",
  violet = "#957fb8",
  warm = "#c0a36e",
  red = "#e46876",
}

local groups = {
  Comment = { fg = colors.muted, italic = true },
  Constant = { fg = colors.violet },
  String = { fg = colors.warm },
  Character = { fg = colors.warm },
  Number = { fg = colors.violet },
  Boolean = { fg = colors.violet },
  Float = { fg = colors.violet },
  Identifier = { fg = colors.fg },
  Function = { fg = colors.blue },
  Statement = { fg = colors.violet },
  Keyword = { fg = colors.violet },
  Conditional = { fg = colors.violet },
  Repeat = { fg = colors.violet },
  Operator = { fg = colors.violet },
  PreProc = { fg = colors.violet },
  Type = { fg = colors.blue },
  Special = { fg = colors.warm },
  DiagnosticError = { fg = colors.red },
  DiagnosticWarn = { fg = colors.warm },
  DiagnosticInfo = { fg = colors.blue },
  DiagnosticHint = { fg = colors.muted },
  Search = { fg = colors.bg, bg = colors.blue },
  IncSearch = { fg = colors.bg, bg = colors.warm },
  Visual = { bg = "#223249" },
  PmenuSel = { fg = colors.bg, bg = colors.blue },
}

for group, opts in pairs(groups) do
  hl(0, group, opts)
end

for group, target in pairs({
  ["@comment"] = "Comment",
  ["@constant"] = "Constant",
  ["@string"] = "String",
  ["@string.escape"] = "Special",
  ["@number"] = "Number",
  ["@boolean"] = "Boolean",
  ["@variable"] = "Identifier",
  ["@function"] = "Function",
  ["@function.method"] = "Function",
  ["@keyword"] = "Keyword",
  ["@keyword.function"] = "Keyword",
  ["@operator"] = "Operator",
  ["@type"] = "Type",
  ["@type.builtin"] = "Type",
  ["@punctuation.special"] = "Special",
}) do
  hl(0, group, { link = target })
end

vim.g.colors_name = "kanagawa-wave-reduced"
