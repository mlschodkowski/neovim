vim.g.doom_one_cursor_coloring = false
vim.g.doom_one_terminal_colors = true
vim.g.doom_one_italic_comments = false
vim.g.doom_one_enable_treesitter = true
vim.g.doom_one_diagnostics_text_color = false
-- Let Ghostty render the editor surface, including its configured opacity.
vim.g.doom_one_transparent_background = true
vim.g.doom_one_pumblend_enable = false
vim.g.doom_one_pumblend_transparency = 20

local original_colors = require("doom-one.colors")
package.loaded["doom-one.colors"] = {
  get_palette = function(current_bg)
    local palette = original_colors.get_palette(current_bg)
    if current_bg ~= "dark" then
      return palette
    end

    return {
      -- Match Ghostty's Doom One Darker surfaces while retaining Doom One's
      -- native syntax colors and contrast relationships.
      bg = "#171b2b",
      fg = "#d8dcf0",
      bg_alt = "#222943",
      fg_alt = "#8f9bc4",
      base0 = "#111525",
      base1 = "#171b2b",
      base2 = "#1c2235",
      base3 = "#252d49",
      base4 = "#39466f",
      base5 = "#5c6b9b",
      base6 = "#7d8bc0",
      base7 = "#aab5e0",
      base8 = "#e1e5ff",
      grey = "#39466f",
      red = palette.red,
      orange = palette.orange,
      green = palette.green,
      teal = palette.teal,
      yellow = palette.yellow,
      blue = palette.blue,
      dark_blue = palette.dark_blue,
      magenta = palette.magenta,
      violet = palette.violet,
      cyan = palette.cyan,
      dark_cyan = palette.dark_cyan,
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
