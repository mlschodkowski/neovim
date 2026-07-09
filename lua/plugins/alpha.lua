return {
  "goolord/alpha-nvim",
  dependencies = {
    "echasnovski/mini.icons",
  },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      [[  ______________________]],
      [[ /\                     \]],
      [[/  \    _________________\]],
      [[\   \   \                /]],
      [[ \   \   \__________    /]],
      [[  \   \   \    /   /   /]],
      [[   \   \   \  /   /   /]],
      [[    \   \   \/   /   /]],
      [[     \   \  /   /   /]],
      [[      \   \/   /   /]],
      [[       \      /   /]],
      [[        \    /   /]],
      [[         \  /   /]],
      [[          \/___/]],
    }

    dashboard.section.buttons.val = {
      dashboard.button("e", "λ  > New file", ":ene <BAR> startinsert<CR>"),
      dashboard.button("f", "λ  > Find file", ":Telescope find_files<CR>"),
      dashboard.button("g", "λ  > Find text", ":Telescope live_grep<CR>"),
      dashboard.button("b", "λ  > Buffers", ":Telescope buffers<CR>"),
      dashboard.button("r", "λ  > Recent files", ":Telescope oldfiles<CR>"),
      dashboard.button("p", "λ  > Project files", ":Telescope find_files cwd=.<CR>"),
      dashboard.button("s", "λ  > Scratch", ":edit ~/notes/scratch.md<CR>"),
      dashboard.button("c", "λ  > Config files", ":Telescope find_files cwd=~/.config/nvim<CR>"),
      dashboard.button("l", "λ  > Lazy", ":Lazy<CR>"),
      dashboard.button("m", "λ  > Mason", ":Mason<CR>"),
      dashboard.button("q", "λ  > Quit", ":qa<CR>"),
    }

    dashboard.section.footer.val = {
      " ",
      "Helix-like keys: <leader>?  |  Nav: ]d [d ]s [s ]f [f ]p [p ]h [h",
    }

    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)
  end,
}
