return {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  opts = {
    detection_methods = { "pattern" },
    patterns = { ".git", "package.json", "pyproject.toml", "go.mod", "Cargo.toml", ".hg" },
    show_hidden = false,
    silent_chdir = true,
    scope_chdir = "global",
  },
  config = function(_, opts)
    require("project_nvim").setup(opts)
    pcall(require("telescope").load_extension, "projects")
    vim.keymap.set("n", "<leader>cp", "<cmd>Telescope projects<CR>", { desc = "Switch project (cd)" })
  end,
}
