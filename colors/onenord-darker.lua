-- OneNord syntax with subtly deeper neutral UI surfaces and quieter text for Ghostty.
local config = require("onenord.config")
config.options.custom_colors = {
	bg = "#191d24",
	fg = "#bcc4d2",
	fg_light = "#d7dce5",
	active = "#232832",
	float = "#292e38",
	highlight = "#333a45",
	highlight_dark = "#333a45",
	selection = "#4c566a",
}
config.options.theme = nil
require("onenord").load(true)
vim.g.colors_name = "onenord-darker"
