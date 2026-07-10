local ok = pcall(vim.cmd.colorscheme, "monokai-pro-classic")
if not ok then
  vim.cmd.colorscheme("monokai-pro")
end

local hl = vim.api.nvim_set_hl

hl(0, "Comment", { fg = "#85857a", italic = false })
hl(0, "String", { fg = "#b5b58d" })
hl(0, "Character", { fg = "#b5b58d" })
hl(0, "Number", { fg = "#b5aa83" })
hl(0, "Boolean", { fg = "#b5aa83" })
hl(0, "Constant", { fg = "#b2ad8b" })
hl(0, "Identifier", { fg = "#c0bda9" })
hl(0, "Function", { fg = "#b8b48d" })
hl(0, "Keyword", { fg = "#aaa18e" })
hl(0, "Statement", { fg = "#aaa18e" })
hl(0, "Type", { fg = "#b7b18c" })
hl(0, "Structure", { fg = "#b7b18c" })
hl(0, "Special", { fg = "#aca786" })
hl(0, "Operator", { fg = "#a6a48f" })
hl(0, "Delimiter", { fg = "#969681" })

vim.g.colors_name = "monokai-quiet"
