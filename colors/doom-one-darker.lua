vim.g.doom_one_cursor_coloring = false
vim.g.doom_one_terminal_colors = true
vim.g.doom_one_italic_comments = false
vim.g.doom_one_enable_treesitter = true
vim.g.doom_one_diagnostics_text_color = false
vim.g.doom_one_transparent_background = false
vim.g.doom_one_pumblend_enable = false
vim.g.doom_one_pumblend_transparency = 20

local original_colors = require("doom-one.colors")
local utils = require("doom-one.utils")
package.loaded["doom-one.colors"] = {
  get_palette = function(current_bg)
    local palette = original_colors.get_palette(current_bg)
    if current_bg ~= "dark" then
      return palette
    end

    local bg = "#191526"
    local function mute(color, amount)
      return utils.mix(color, bg, amount)
    end

    return {
      bg = bg,
      fg = "#d8cfea",
      bg_alt = "#141121",
      fg_alt = "#81739f",
      base0 = "#100d19",
      base1 = "#151126",
      base2 = "#191526",
      base3 = "#241b38",
      base4 = "#3d2e5c",
      base5 = "#604c86",
      base6 = "#8870ad",
      base7 = "#ad91cf",
      base8 = "#e5d9f2",
      grey = "#4f3b75",
      red = mute(palette.red, 0.14),
      orange = mute(palette.orange, 0.14),
      green = mute(palette.green, 0.14),
      teal = mute(palette.teal, 0.14),
      yellow = mute(palette.yellow, 0.14),
      blue = mute(palette.blue, 0.12),
      dark_blue = "#3d4f9a",
      magenta = mute(palette.magenta, 0.14),
      violet = mute(palette.violet, 0.14),
      cyan = mute(palette.cyan, 0.14),
      dark_cyan = mute(palette.dark_cyan, 0.14),
    }
  end,
}

package.loaded["doom-one"] = nil
vim.g.colors_name = "doom-one-darker"
require("doom-one").set_colorscheme()
vim.api.nvim_set_hl(0, "Keyword", { fg = "#6fa8dc" })
vim.api.nvim_set_hl(0, "Statement", { fg = "#6fa8dc" })
vim.api.nvim_set_hl(0, "Exception", { fg = "#6fa8dc" })
vim.api.nvim_set_hl(0, "Conditional", { fg = "#6fa8dc" })
vim.api.nvim_set_hl(0, "@keyword", { link = "Keyword" })
vim.api.nvim_set_hl(0, "@exception", { link = "Exception" })
package.loaded["doom-one.colors"] = original_colors
