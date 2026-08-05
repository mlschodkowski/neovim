return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
    keys = {
      { "<leader>gd", "<cmd>Gitsigns diffthis<CR>", desc = "Diff current file" },
      { "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", desc = "Preview change" },
      { "<leader>gh", "<cmd>Gitsigns stage_hunk<CR>", desc = "Stage change" },
      { "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>", desc = "Unstage change" },
      { "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", desc = "Reset change" },
      { "<leader>gS", "<cmd>Gitsigns stage_buffer<CR>", desc = "Stage buffer" },
      { "<leader>gU", "<cmd>Gitsigns reset_buffer_index<CR>", desc = "Unstage buffer" },
    },
  },
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<CR>", desc = "Open LazyGit" },
      { "<leader>gF", "<cmd>LazyGitCurrentFile<CR>", desc = "Open LazyGit for current file" },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Git status" },
      { "<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "Switch branch" },
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Git commits" },
      { "<leader>gC", "<cmd>Telescope git_bcommits<CR>", desc = "Buffer commits" },
    },
  },
}
