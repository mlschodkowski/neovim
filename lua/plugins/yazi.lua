return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  opts = {
    open_for_directories = false,
    change_neovim_cwd_on_close = true,
    yazi_floating_window_border = "rounded",
  },
  keys = {
    { "<leader>y", "<cmd>Yazi cwd<CR>", desc = "Open Yazi in cwd" },
    { "<leader>fy", "<cmd>Yazi cwd<CR>", desc = "Open Yazi in cwd" },
    { "<leader>yc", "<cmd>Yazi<CR>", desc = "Open Yazi (buffer path)" },
  },
}
