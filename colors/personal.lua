vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "personal"

local palette = {
  bg = "#0d1117",
  surface = "#141b24",
  raised = "#1d2a38",
  selection = "#263a50",
  fg = "#d5dde7",
  muted = "#8593a5",
  comment = "#68778a",
  border = "#334457",
  blue = "#7da7c4",
  green = "#86ad91",
  amber = "#d2ae78",
  red = "#cf7b7b",
  magenta = "#b494c4",
}

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal", { fg = palette.fg, bg = palette.bg })
hl("NormalNC", { fg = palette.fg, bg = palette.bg })
hl("NormalFloat", { fg = palette.fg, bg = palette.surface })
hl("FloatBorder", { fg = palette.border, bg = palette.surface })
hl("WinSeparator", { fg = palette.border, bg = palette.bg })
hl("CursorLine", { bg = palette.raised })
hl("CursorLineNr", { fg = palette.amber, bg = palette.raised, bold = true })
hl("LineNr", { fg = palette.muted, bg = palette.bg })
hl("LineNrAbove", { fg = palette.comment, bg = palette.bg })
hl("LineNrBelow", { fg = palette.comment, bg = palette.bg })
hl("Visual", { bg = palette.selection })
hl("Search", { fg = palette.bg, bg = palette.amber })
hl("IncSearch", { fg = palette.bg, bg = palette.blue })
hl("MatchParen", { fg = palette.amber, bg = palette.raised, bold = true })
hl("Pmenu", { fg = palette.fg, bg = palette.surface })
hl("PmenuSel", { fg = palette.fg, bg = palette.selection, bold = true })
hl("PmenuSbar", { bg = palette.surface })
hl("PmenuThumb", { bg = palette.muted })
hl("StatusLine", { fg = palette.fg, bg = palette.surface })
hl("StatusLineNC", { fg = palette.muted, bg = palette.surface })
hl("TabLine", { fg = palette.muted, bg = palette.surface })
hl("TabLineSel", { fg = palette.fg, bg = palette.raised, bold = true })

hl("Comment", { fg = palette.comment, italic = true })
hl("Constant", { fg = palette.green })
hl("String", { fg = palette.green })
hl("Character", { fg = palette.green })
hl("Number", { fg = palette.amber })
hl("Boolean", { fg = palette.amber })
hl("Identifier", { fg = palette.fg })
hl("Function", { fg = palette.blue })
hl("Statement", { fg = palette.blue, bold = true })
hl("Keyword", { fg = palette.blue, bold = true })
hl("Conditional", { fg = palette.blue })
hl("Repeat", { fg = palette.blue })
hl("Operator", { fg = palette.fg })
hl("Type", { fg = palette.amber })
hl("PreProc", { fg = palette.magenta })
hl("Special", { fg = palette.muted })
hl("Delimiter", { fg = palette.muted })
hl("NonText", { fg = palette.comment })

hl("DiagnosticError", { fg = palette.red })
hl("DiagnosticWarn", { fg = palette.amber })
hl("DiagnosticInfo", { fg = palette.blue })
hl("DiagnosticHint", { fg = palette.green })
hl("DiagnosticVirtualTextError", { fg = palette.red, bg = palette.surface })
hl("DiagnosticVirtualTextWarn", { fg = palette.amber, bg = palette.surface })
hl("DiagnosticVirtualTextInfo", { fg = palette.blue, bg = palette.surface })
hl("DiagnosticVirtualTextHint", { fg = palette.green, bg = palette.surface })

hl("@comment", { link = "Comment" })
hl("@string", { link = "String" })
hl("@number", { link = "Number" })
hl("@boolean", { link = "Boolean" })
hl("@function", { link = "Function" })
hl("@function.call", { link = "Function" })
hl("@keyword", { link = "Keyword" })
hl("@keyword.function", { link = "Keyword" })
hl("@type", { link = "Type" })
hl("@property", { fg = palette.fg })
hl("@variable.member", { fg = palette.fg })
hl("@variable.builtin", { fg = palette.fg })
hl("@lsp.type.property", { fg = palette.fg })
hl("@lsp.type.variable", { fg = palette.fg })

hl("lualine_a_normal", { fg = palette.bg, bg = palette.amber, bold = true })
hl("lualine_b_normal", { fg = palette.fg, bg = palette.raised })
hl("lualine_c_normal", { fg = palette.fg, bg = palette.surface })
hl("lualine_x_normal", { fg = palette.muted, bg = palette.surface })
hl("lualine_y_normal", { fg = palette.fg, bg = palette.raised })
hl("lualine_z_normal", { fg = palette.bg, bg = palette.blue, bold = true })
hl("lualine_c_inactive", { fg = palette.comment, bg = palette.surface })

hl("BufferLineFill", { bg = palette.surface })
hl("BufferLineBackground", { fg = palette.muted, bg = palette.surface })
hl("BufferLineBufferSelected", { fg = palette.fg, bg = palette.raised, bold = true })
hl("BufferLineSeparator", { fg = palette.surface, bg = palette.surface })
hl("BufferLineSeparatorSelected", { fg = palette.surface, bg = palette.raised })
hl("BufferLineIndicatorSelected", { fg = palette.amber, bg = palette.raised })
