vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.o.background = "dark"
vim.g.colors_name = "claude-dark"

local palette = {
  bg = "#1c1917",
  surface = "#25211f",
  raised = "#302a27",
  selection = "#49352a",
  fg = "#f5eee6",
  muted = "#b2a69b",
  comment = "#85786e",
  border = "#493f39",
  orange = "#d97757",
  orange_bright = "#e68a68",
  yellow = "#d6b06d",
  green = "#a8b878",
  red = "#e8836f",
  blue = "#8ab4c7",
  violet = "#c6a0c9",
}

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal", { fg = palette.fg, bg = palette.bg })
hl("NormalNC", { fg = palette.fg, bg = palette.bg })
hl("NormalFloat", { fg = palette.fg, bg = palette.surface })
hl("FloatBorder", { fg = palette.border, bg = palette.surface })
hl("WinSeparator", { fg = palette.border, bg = palette.bg })
hl("SignColumn", { fg = palette.comment, bg = palette.bg })
hl("FoldColumn", { fg = palette.comment, bg = palette.bg })
hl("EndOfBuffer", { fg = palette.bg, bg = palette.bg })
hl("CursorLine", { bg = palette.raised })
hl("CursorLineNr", { fg = palette.orange_bright, bg = palette.raised, bold = true })
hl("LineNr", { fg = palette.muted, bg = palette.bg })
hl("LineNrAbove", { fg = palette.comment, bg = palette.bg })
hl("LineNrBelow", { fg = palette.comment, bg = palette.bg })
hl("ColorColumn", { bg = palette.raised })
hl("Visual", { bg = palette.selection })
hl("Search", { fg = palette.bg, bg = palette.orange })
hl("IncSearch", { fg = palette.bg, bg = palette.yellow })
hl("CurSearch", { fg = palette.bg, bg = palette.orange_bright })
hl("MatchParen", { fg = palette.orange_bright, bg = palette.raised, bold = true })
hl("Pmenu", { fg = palette.fg, bg = palette.surface })
hl("PmenuSel", { fg = palette.fg, bg = palette.selection, bold = true })
hl("PmenuSbar", { bg = palette.raised })
hl("PmenuThumb", { bg = palette.muted })
hl("StatusLine", { fg = palette.fg, bg = palette.surface })
hl("StatusLineNC", { fg = palette.muted, bg = palette.surface })
hl("TabLine", { fg = palette.muted, bg = palette.surface })
hl("TabLineSel", { fg = palette.fg, bg = palette.raised, bold = true })
hl("TabLineFill", { bg = palette.surface })

hl("Comment", { fg = palette.comment, italic = true })
hl("Constant", { fg = palette.violet })
hl("String", { fg = palette.green })
hl("Character", { fg = palette.green })
hl("Number", { fg = palette.yellow })
hl("Boolean", { fg = palette.yellow })
hl("Float", { fg = palette.yellow })
hl("Identifier", { fg = palette.fg })
hl("Function", { fg = palette.blue })
hl("Statement", { fg = palette.orange_bright, bold = true })
hl("Keyword", { fg = palette.orange_bright, bold = true })
hl("Conditional", { fg = palette.orange_bright })
hl("Repeat", { fg = palette.orange_bright })
hl("Operator", { fg = palette.fg })
hl("Type", { fg = palette.yellow })
hl("PreProc", { fg = palette.violet })
hl("Special", { fg = palette.orange })
hl("Delimiter", { fg = palette.muted })
hl("NonText", { fg = palette.comment })
hl("Title", { fg = palette.orange_bright, bold = true })
hl("Directory", { fg = palette.blue })
hl("Error", { fg = palette.red })
hl("ErrorMsg", { fg = palette.red, bg = palette.bg })
hl("WarningMsg", { fg = palette.yellow, bg = palette.bg })

hl("DiagnosticError", { fg = palette.red })
hl("DiagnosticWarn", { fg = palette.yellow })
hl("DiagnosticInfo", { fg = palette.blue })
hl("DiagnosticHint", { fg = palette.green })
hl("DiagnosticOk", { fg = palette.green })
hl("DiagnosticVirtualTextError", { fg = palette.red, bg = palette.surface })
hl("DiagnosticVirtualTextWarn", { fg = palette.yellow, bg = palette.surface })
hl("DiagnosticVirtualTextInfo", { fg = palette.blue, bg = palette.surface })
hl("DiagnosticVirtualTextHint", { fg = palette.green, bg = palette.surface })
hl("DiagnosticUnderlineError", { undercurl = true, sp = palette.red })
hl("DiagnosticUnderlineWarn", { undercurl = true, sp = palette.yellow })
hl("DiagnosticUnderlineInfo", { undercurl = true, sp = palette.blue })
hl("DiagnosticUnderlineHint", { undercurl = true, sp = palette.green })

for group, target in pairs({
  ["@comment"] = "Comment",
  ["@constant"] = "Constant",
  ["@string"] = "String",
  ["@string.escape"] = "Special",
  ["@character"] = "Character",
  ["@number"] = "Number",
  ["@boolean"] = "Boolean",
  ["@float"] = "Float",
  ["@function"] = "Function",
  ["@function.call"] = "Function",
  ["@function.method"] = "Function",
  ["@keyword"] = "Keyword",
  ["@keyword.function"] = "Keyword",
  ["@keyword.operator"] = "Keyword",
  ["@conditional"] = "Conditional",
  ["@repeat"] = "Repeat",
  ["@operator"] = "Operator",
  ["@type"] = "Type",
  ["@type.builtin"] = "Type",
  ["@constructor"] = "Type",
  ["@namespace"] = "Type",
  ["@property"] = "Identifier",
  ["@variable.member"] = "Identifier",
  ["@variable.builtin"] = "Special",
  ["@punctuation.delimiter"] = "Delimiter",
  ["@punctuation.special"] = "Special",
  ["@tag"] = "Special",
  ["@tag.attribute"] = "Identifier",
  ["@markup.heading"] = "Title",
  ["@markup.link"] = "Underlined",
  ["@markup.raw"] = "String",
  ["@lsp.type.property"] = "Identifier",
  ["@lsp.type.variable"] = "Identifier",
}) do
  hl(group, { link = target })
end

hl("lualine_a_normal", { fg = palette.bg, bg = palette.orange, bold = true })
hl("lualine_b_normal", { fg = palette.fg, bg = palette.raised })
hl("lualine_c_normal", { fg = palette.fg, bg = palette.surface })
hl("lualine_x_normal", { fg = palette.muted, bg = palette.surface })
hl("lualine_y_normal", { fg = palette.fg, bg = palette.raised })
hl("lualine_z_normal", { fg = palette.bg, bg = palette.yellow, bold = true })
hl("lualine_c_inactive", { fg = palette.comment, bg = palette.surface })

hl("BufferLineFill", { bg = palette.surface })
hl("BufferLineBackground", { fg = palette.muted, bg = palette.surface })
hl("BufferLineBufferSelected", { fg = palette.fg, bg = palette.raised, bold = true })
hl("BufferLineSeparator", { fg = palette.surface, bg = palette.surface })
hl("BufferLineSeparatorSelected", { fg = palette.surface, bg = palette.raised })
hl("BufferLineIndicatorSelected", { fg = palette.orange, bg = palette.raised })
