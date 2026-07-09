return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    open_mapping = nil,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    direction = "float",
    float_opts = {
      border = "rounded",
    },
  },
  keys = {
    { "<leader>tt", "<cmd>ToggleTerm direction=float<CR>", desc = "Toggle floating terminal" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal size=14<CR>", desc = "Toggle horizontal terminal" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=45<CR>", desc = "Toggle vertical terminal" },
    { "<A-i>", "<cmd>ToggleTerm direction=float<CR>", desc = "Toggle floating terminal" },
    { "<Esc>", "<C-\\><C-n>", mode = "t", desc = "Exit terminal mode" },
  },
}
