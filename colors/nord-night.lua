-- Port of Helix's built-in Nord Night theme.
if not pcall(vim.cmd.colorscheme, "nord") then
	return
end

local hl = vim.api.nvim_set_hl
local colors = {
	bg = "#252933",
	fg = "#C0C5CF",
	surface = "#3B4252",
	raised = "#434C5E",
	muted = "#4C566A",
	comment = "#616E88",
	cyan = "#8FBCBB",
	blue = "#88C0D0",
	frost = "#81A1C1",
	red = "#BF616A",
	yellow = "#EBCB8B",
	green = "#A3BE8C",
	magenta = "#B48EAD",
}

for group, opts in pairs({
	Normal = { fg = colors.fg, bg = colors.bg },
	NormalNC = { fg = colors.fg, bg = colors.bg },
	NormalFloat = { fg = colors.fg, bg = colors.surface },
	FloatBorder = { fg = colors.surface, bg = colors.surface },
	WinSeparator = { fg = colors.surface, bg = colors.bg },
	SignColumn = { fg = colors.muted, bg = colors.bg },
	EndOfBuffer = { fg = colors.bg, bg = colors.bg },
	CursorLine = { bg = colors.surface },
	CursorLineNr = { fg = "#E5E9F0", bg = colors.surface, bold = true },
	LineNr = { fg = colors.muted, bg = colors.bg },
	Visual = { bg = colors.muted },
	Search = { fg = colors.bg, bg = colors.yellow },
	IncSearch = { fg = colors.bg, bg = colors.blue },
	Pmenu = { fg = colors.fg, bg = colors.surface },
	PmenuSel = { fg = colors.blue, bg = colors.raised },
	StatusLine = { fg = colors.fg, bg = colors.surface },
	StatusLineNC = { fg = colors.blue, bg = colors.surface },
	Comment = { fg = colors.comment, italic = true },
	Constant = { fg = colors.yellow },
	Boolean = { fg = colors.yellow },
	Number = { fg = colors.yellow },
	Function = { fg = colors.blue },
	Type = { fg = colors.cyan },
	Keyword = { fg = colors.frost },
	Conditional = { fg = colors.red },
	Repeat = { fg = colors.red },
	Exception = { fg = colors.red },
	Statement = { fg = colors.frost },
	Identifier = { fg = colors.fg },
	Special = { fg = colors.frost },
	Delimiter = { fg = colors.fg },
	DiagnosticError = { fg = colors.red },
	DiagnosticWarn = { fg = colors.yellow },
	DiagnosticInfo = { fg = colors.blue },
	DiagnosticHint = { fg = colors.green },
}) do
	hl(0, group, opts)
end

for group, target in pairs({
	["@comment"] = "Comment",
	["@constant"] = "Constant",
	["@constant.builtin"] = "Constant",
	["@boolean"] = "Boolean",
	["@number"] = "Number",
	["@function"] = "Function",
	["@function.method"] = "Function",
	["@type"] = "Type",
	["@type.builtin"] = "Type",
	["@keyword"] = "Keyword",
	["@keyword.conditional"] = "Conditional",
	["@keyword.repeat"] = "Repeat",
	["@keyword.exception"] = "Exception",
	["@keyword.return"] = "Conditional",
	["@variable.parameter"] = "Special",
}) do
	hl(0, group, { link = target })
end

hl(0, "@variable.parameter", { fg = colors.magenta })
vim.g.colors_name = "nord-night"
