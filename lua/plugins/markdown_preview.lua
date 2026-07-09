return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    cmd = {
      "RenderMarkdown",
      "MarkdownPreviewToggle",
      "MarkdownPreview",
      "MarkdownPreviewStop",
    },
    opts = {},
    config = function(_, opts)
      require("render-markdown").setup(opts)

      vim.api.nvim_create_user_command("MarkdownPreviewToggle", function()
        vim.cmd("RenderMarkdown toggle")
      end, { desc = "Toggle markdown render preview" })

      vim.api.nvim_create_user_command("MarkdownPreview", function()
        vim.cmd("RenderMarkdown enable")
      end, { desc = "Enable markdown render preview" })

      vim.api.nvim_create_user_command("MarkdownPreviewStop", function()
        vim.cmd("RenderMarkdown disable")
      end, { desc = "Disable markdown render preview" })
    end,
  },
}
