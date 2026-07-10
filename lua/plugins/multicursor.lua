return {
  "mg979/vim-visual-multi",
  branch = "master",
  init = function()
    vim.g.VM_default_mappings = 0
    vim.g.VM_maps = {
      ["Find Under"] = "<C-n>",
      ["Find Subword Under"] = "<C-n>",
      ["Select All"] = "\\A",
      ["Add Cursor Down"] = "<M-C-j>",
      ["Add Cursor Up"] = "<M-C-k>",
      ["Remove Region"] = "q",
    }
  end,
}
