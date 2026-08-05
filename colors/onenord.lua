-- Load the upstream OneNord syntax and plugin highlights without overrides.
local config = require("onenord.config")
config.options.custom_colors = {}
config.options.theme = nil
require("onenord").load(true)
