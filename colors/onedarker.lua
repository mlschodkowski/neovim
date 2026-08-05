-- Port of the Helix better-darker (One Darker) theme.
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.o.background = "dark"
vim.g.colors_name = "onedarker"

local palette = {
  yellow = "#D5B06B",
  blue = "#519FDF",
  red = "#D05C65",
  purple = "#B668CD",
  green = "#7DA869",
  gold = "#D19A66",
  cyan = "#46A6B2",
  white = "#ABB2BF",
  black = "#16181A",
  dark_black = "#12100E",
  light_black = "#2C323C",
  gray = "#252D30",
  faint_gray = "#ABB2BF",
  light_gray = "#636C6E",
  line_number = "#282C34",
}

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal", { fg = palette.white, bg = palette.black })
hl("NormalNC", { fg = palette.white, bg = palette.black })
hl("NormalFloat", { fg = palette.white, bg = palette.gray })
hl("FloatBorder", { fg = palette.gray, bg = palette.gray })
hl("WinSeparator", { fg = palette.gray, bg = palette.black })
hl("SignColumn", { fg = palette.light_gray, bg = palette.black })
hl("FoldColumn", { fg = palette.light_gray, bg = palette.black })
hl("EndOfBuffer", { fg = palette.black, bg = palette.black })
hl("CursorLine", { bg = palette.dark_black })
hl("CursorLineNr", { fg = palette.white, bg = palette.dark_black, bold = true })
hl("LineNr", { fg = palette.line_number, bg = palette.black })
hl("LineNrAbove", { fg = palette.line_number, bg = palette.black })
hl("LineNrBelow", { fg = palette.line_number, bg = palette.black })
hl("ColorColumn", { bg = palette.gray })
hl("Visual", { fg = palette.black, bg = palette.white })
hl("Search", { fg = palette.black, bg = palette.gold })
hl("IncSearch", { fg = palette.black, bg = palette.blue })
hl("CurSearch", { fg = palette.black, bg = palette.blue })
hl("MatchParen", { fg = palette.blue, underline = true })
hl("Pmenu", { fg = palette.white, bg = palette.gray })
hl("PmenuSel", { fg = palette.black, bg = palette.blue })
hl("PmenuSbar", { bg = palette.gray })
hl("PmenuThumb", { bg = palette.light_gray })
hl("StatusLine", { fg = palette.white, bg = palette.light_black })
hl("StatusLineNC", { fg = palette.light_gray, bg = palette.light_black })
hl("TabLine", { fg = palette.light_gray, bg = palette.light_black })
hl("TabLineSel", { fg = palette.black, bg = palette.blue, underline = true })
hl("TabLineFill", { bg = palette.light_black })
hl("Directory", { fg = palette.blue })
hl("Title", { fg = palette.red })
hl("ErrorMsg", { fg = palette.red, bg = palette.black })
hl("WarningMsg", { fg = palette.yellow, bg = palette.black })
hl("MoreMsg", { fg = palette.green })
hl("Question", { fg = palette.blue })
hl("Whitespace", { fg = palette.light_gray })
hl("NonText", { fg = palette.faint_gray })

hl("Comment", { fg = palette.light_gray, italic = true })
hl("Constant", { fg = palette.gold })
hl("String", { fg = palette.green })
hl("Character", { fg = palette.gold })
hl("Number", { fg = palette.gold })
hl("Boolean", { fg = palette.gold })
hl("Float", { fg = palette.gold })
hl("Identifier", { fg = palette.white })
hl("Function", { fg = palette.white })
hl("Statement", { fg = palette.purple })
hl("Keyword", { fg = palette.purple })
hl("Conditional", { fg = palette.purple })
hl("Repeat", { fg = palette.purple })
hl("Label", { fg = palette.purple })
hl("Operator", { fg = palette.white })
hl("PreProc", { fg = palette.purple })
hl("Macro", { fg = palette.purple })
hl("Type", { fg = palette.yellow })
hl("StorageClass", { fg = palette.yellow })
hl("Structure", { fg = palette.yellow })
hl("Typedef", { fg = palette.yellow })
hl("Special", { fg = palette.blue })
hl("SpecialChar", { fg = palette.gold })
hl("Delimiter", { fg = palette.white })
hl("Underlined", { fg = palette.blue, underline = true })
hl("Todo", { fg = palette.black, bg = palette.yellow, bold = true })
hl("Error", { fg = palette.red })

hl("DiagnosticError", { fg = palette.red })
hl("DiagnosticWarn", { fg = palette.yellow })
hl("DiagnosticInfo", { fg = palette.blue })
hl("DiagnosticHint", { fg = palette.green })
hl("DiagnosticOk", { fg = palette.green })
hl("DiagnosticVirtualTextError", { fg = palette.red, bg = palette.black })
hl("DiagnosticVirtualTextWarn", { fg = palette.yellow, bg = palette.black })
hl("DiagnosticVirtualTextInfo", { fg = palette.blue, bg = palette.black })
hl("DiagnosticVirtualTextHint", { fg = palette.green, bg = palette.black })
hl("DiagnosticUnderlineError", { undercurl = true, sp = palette.red })
hl("DiagnosticUnderlineWarn", { undercurl = true, sp = palette.yellow })
hl("DiagnosticUnderlineInfo", { undercurl = true, sp = palette.blue })
hl("DiagnosticUnderlineHint", { undercurl = true, sp = palette.green })
hl("DiagnosticUnnecessary", { fg = palette.light_gray })
hl("DiagnosticDeprecated", { strikethrough = true })

for group, target in pairs({
  ["@attribute"] = "Type",
  ["@comment"] = "Comment",
  ["@constant"] = "Constant",
  ["@constant.builtin"] = "Constant",
  ["@string"] = "String",
  ["@string.escape"] = "SpecialChar",
  ["@character"] = "Character",
  ["@number"] = "Number",
  ["@boolean"] = "Boolean",
  ["@function"] = "Function",
  ["@function.call"] = "Function",
  ["@function.builtin"] = "Special",
  ["@function.macro"] = "Macro",
  ["@constructor"] = "Special",
  ["@keyword"] = "Keyword",
  ["@keyword.import"] = "Keyword",
  ["@keyword.directive"] = "Keyword",
  ["@keyword.operator"] = "Operator",
  ["@label"] = "Label",
  ["@operator"] = "Operator",
  ["@type"] = "Type",
  ["@type.builtin"] = "Type",
  ["@namespace"] = "Keyword",
  ["@variable"] = "Identifier",
  ["@variable.builtin"] = "Identifier",
  ["@variable.parameter"] = "Identifier",
  ["@variable.member"] = "Special",
  ["@property"] = "Special",
  ["@markup.heading"] = "Title",
  ["@markup.raw"] = "String",
  ["@markup.strong"] = "Constant",
  ["@markup.italic"] = "Keyword",
  ["@markup.strikethrough"] = "DiagnosticDeprecated",
  ["@markup.list"] = "Title",
  ["@markup.quote"] = "Type",
  ["@markup.link.url"] = "Underlined",
  ["@markup.link.label"] = "Identifier",
  ["@lsp.type.property"] = "Special",
  ["@lsp.type.variable"] = "Identifier",
}) do
  hl(group, { link = target })
end

hl("@markup.strong", { fg = palette.gold, bold = true })
hl("@markup.italic", { fg = palette.purple, italic = true })
