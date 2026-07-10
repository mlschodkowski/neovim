return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  opts = {
    open_for_directories = false,
    change_neovim_cwd_on_close = true,
    yazi_floating_window_border = "rounded",
    open_file_function = function(chosen_file)
      if vim.fn.isdirectory(chosen_file) == 1 then
        vim.cmd.cd(chosen_file)
        vim.schedule(function()
          require("telescope.builtin").find_files({ cwd = chosen_file })
        end)
        return
      end

      require("yazi.openers").open_file(chosen_file)
    end,
  },
  keys = {
    { "<leader>y", "<cmd>Yazi toggle<CR>", desc = "Toggle Yazi in cwd" },
    { "<leader>fy", "<cmd>Yazi toggle<CR>", desc = "Toggle Yazi in cwd" },
    { "<leader>yc", "<cmd>Yazi<CR>", desc = "Open Yazi (buffer path)" },
  },
}
