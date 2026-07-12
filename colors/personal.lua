vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "personal"

local bg           = "#0b0f14"
local fg           = "#cbd5e1"
local muted        = "#3b4252"
local comment      = "#5c6b73"
local key_blue     = "#5f85a6"
local string_green = "#6e8c78"

local hl = function(group, opts) vim.api.nvim_set_hl(0, group, opts) end

hl("Normal",     { fg = fg,           bg = bg })
hl("Identifier", { fg = fg })
hl("Function",   { fg = fg })
hl("Type",       { fg = fg })

hl("Statement",  { fg = key_blue,     bold = true })
hl("PreProc",    { fg = key_blue })
hl("Constant",   { fg = string_green })
hl("String",     { fg = string_green })

hl("Delimiter",  { fg = muted })
hl("Special",    { fg = muted })
hl("Operator",   { fg = fg })
hl("NonText",    { fg = muted })
hl("Comment",    { fg = comment,      italic = true })

hl("LineNr",     { fg = muted,        bg = bg })
hl("CursorLine", { bg = "#141a24" })
hl("Visual",     { bg = "#1e293b" })
hl("Search",     { fg = bg,           bg = key_blue })
