return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    close_if_last_window = true,
    filesystem = {
      follow_current_file = {
        enabled = true,
      },
      filtered_items = {
        hide_dotfiles = false,
      },
    },
  },
  keys = {
    { "<leader>e", "<cmd>Neotree toggle filesystem reveal left<CR>", desc = "Toggle file tree" },
    { "<leader>fe", "<cmd>Neotree focus filesystem left<CR>", desc = "Focus file tree" },
  },
}
