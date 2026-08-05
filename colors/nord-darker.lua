-- Standard Nord with only its editor canvas darkened.
if not pcall(vim.cmd, "runtime colors/nord.lua") then
	return
end

local bg = "#252933"
local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
normal.bg = bg
vim.api.nvim_set_hl(0, "Normal", normal)

-- Keep Nord's plugin integrations and ColorScheme hooks intact.
vim.g.colors_name = "nord"
