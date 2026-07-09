return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      mode = "buffers",
      always_show_bufferline = true,
      show_buffer_close_icons = false,
      show_close_icon = false,
      separator_style = "thin",
      diagnostics = "nvim_lsp",
    },
  },
}
