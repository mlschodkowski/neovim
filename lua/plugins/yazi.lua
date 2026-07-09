return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  opts = {
    open_for_directories = false,
    yazi_floating_window_border = "rounded",
  },
  keys = {
    { "<leader>y", "<cmd>Yazi<CR>", desc = "Open Yazi" },
    { "<leader>fy", "<cmd>Yazi cwd<CR>", desc = "Open Yazi in cwd" },
  },
}
