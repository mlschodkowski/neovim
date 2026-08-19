-- Mint Signal: mostly monochrome with Mono Glow's mint accent.
local c = {
  bg = "#111111",
  panel = "#191919",
  surface = "#2a2a2a",
  hover = "#353535",
  selection = "#20382b",
  fg = "#cccccc",
  muted = "#aaaaaa",
  dim = "#707070",
  faint = "#444444",
  mint = "#1bfd9c",
  mint_bright = "#66ffad",
  mint_soft = "#9ed9c1",
  steel_slate = "#8fa6b8",
  red = "#ff8f8f",
  amber = "#c9b678",
}

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.g.colors_name = "mint-signal"

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hi("Normal", { fg = c.fg, bg = c.bg })
hi("NormalNC", { fg = c.fg, bg = c.bg })
hi("NormalFloat", { fg = c.fg, bg = c.panel })
hi("FloatBorder", { fg = c.mint, bg = c.panel })
hi("SignColumn", { fg = c.dim, bg = c.bg })
hi("FoldColumn", { fg = c.faint, bg = c.bg })
hi("EndOfBuffer", { fg = c.bg, bg = c.bg })
hi("CursorLine", { bg = c.panel })
hi("CursorLineNr", { fg = c.mint, bg = c.panel, bold = true })
hi("LineNr", { fg = c.faint, bg = c.bg })
hi("Visual", { bg = c.selection })
hi("Search", { fg = c.bg, bg = c.mint })
hi("IncSearch", { fg = c.bg, bg = c.mint_bright, bold = true })
hi("CurSearch", { fg = c.bg, bg = c.mint_bright, bold = true })
hi("MatchParen", { fg = c.mint, underline = true, bold = true })
hi("Pmenu", { fg = c.fg, bg = c.panel })
hi("PmenuSel", { fg = c.bg, bg = c.mint, bold = true })
hi("PmenuSbar", { bg = c.surface })
hi("PmenuThumb", { bg = c.mint })
hi("StatusLine", { fg = c.fg, bg = c.panel })
hi("StatusLineNC", { fg = c.dim, bg = c.bg })
hi("TabLine", { fg = c.dim, bg = c.bg })
hi("TabLineSel", { fg = c.bg, bg = c.mint, bold = true })
hi("WinSeparator", { fg = c.surface, bg = c.bg })
hi("VertSplit", { fg = c.surface, bg = c.bg })
hi("Directory", { fg = c.mint })
hi("Title", { fg = c.mint, bold = true })
hi("Question", { fg = c.mint })
hi("MoreMsg", { fg = c.mint })
hi("ModeMsg", { fg = c.mint, bold = true })
hi("WarningMsg", { fg = c.amber })
hi("ErrorMsg", { fg = c.red })
hi("DiagnosticError", { fg = c.red })
hi("DiagnosticWarn", { fg = c.amber })
hi("DiagnosticInfo", { fg = c.mint_soft })
hi("DiagnosticHint", { fg = c.mint_soft })
hi("DiffAdd", { fg = c.mint, bg = "#1d3328" })
hi("DiffChange", { fg = c.amber, bg = "#332f20" })
hi("DiffDelete", { fg = c.red, bg = "#332326" })
hi("GitSignsAdd", { fg = c.mint })
hi("GitSignsChange", { fg = c.amber })
hi("GitSignsDelete", { fg = c.red })

for _, group in ipairs({ "Comment", "Conceal", "NonText", "SpecialKey", "Whitespace" }) do
  hi(group, { fg = c.dim, italic = group == "Comment" })
end
for _, group in ipairs({ "Identifier", "Variable" }) do
  hi(group, { fg = c.fg })
end
for _, group in ipairs({ "Constant", "String", "Character", "Number", "Boolean", "Float", "StorageClass" }) do
  hi(group, { fg = c.muted })
end
for _, group in ipairs({ "Type", "Structure" }) do
  hi(group, { fg = c.steel_slate })
end
for _, group in ipairs({ "Function", "Method" }) do
  hi(group, { fg = c.fg })
end
for _, group in ipairs({ "Special", "Underlined", "PreProc", "Include", "Define", "Macro" }) do
  hi(group, { fg = c.muted })
end
hi("Tag", { fg = c.steel_slate })
hi("Statement", { fg = c.muted, bold = true })
hi("Keyword", { fg = c.muted, bold = true })
hi("Delimiter", { fg = c.muted })
hi("Operator", { fg = c.mint })
hi("String", { fg = c.steel_slate })
hi("@function", { fg = c.fg })
hi("@function.call", { fg = c.fg })
hi("@keyword", { fg = c.muted, bold = true })
hi("@operator", { fg = c.mint })
hi("@string", { fg = c.steel_slate })
hi("@string.escape", { fg = c.mint_soft })
hi("@string.special", { fg = c.steel_slate })
hi("@string.regex", { fg = c.mint_soft })
hi("@type", { fg = c.steel_slate })
hi("@type.builtin", { fg = c.steel_slate })
hi("@constructor", { fg = c.steel_slate })
hi("@constant.builtin", { fg = c.steel_slate })
hi("@tag", { fg = c.steel_slate })
hi("@tag.attribute", { fg = c.steel_slate })
hi("@variable", { fg = c.fg })
hi("@comment", { fg = c.dim, italic = true })
hi("@punctuation.delimiter", { fg = c.muted })
hi("@punctuation.bracket", { fg = c.muted })
hi("@punctuation.special", { fg = c.mint })
hi("@attribute", { fg = c.steel_slate })
