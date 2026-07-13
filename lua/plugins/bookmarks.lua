return {
  "tristone13th/lspmark.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("lspmark").setup({
      telescope = {
        entry_fields = {
          order = { "comment", "file", "kind", "symbol" },
          max_widths = { comment = 0.4 },
        },
      },
    })
    require("telescope").load_extension("lspmark")

    vim.api.nvim_create_autocmd("DirChanged", {
      group = vim.api.nvim_create_augroup("LspmarkProjectBookmarks", { clear = true }),
      callback = require("lspmark.bookmarks").load_bookmarks,
    })
    require("lspmark.bookmarks").load_bookmarks()
  end,
  keys = {
    {
      "<leader>ja",
      function()
        require("lspmark.bookmarks").toggle_bookmark({ with_comment = false })
      end,
      desc = "Toggle project bookmark",
    },
    {
      "<leader>jb",
      function()
        require("telescope").extensions.lspmark.lspmark()
      end,
      desc = "Browse project bookmarks",
    },
  },
}
