return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup({
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
        key = function()
          return vim.loop.cwd()
        end,
      },
    })

    vim.keymap.set("n", "<leader>js", function()
      harpoon:list():add()
    end, { desc = "Jump: save current file" })
    vim.keymap.set("n", "<leader>jj", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Jump: open marks list" })
    vim.keymap.set("n", "<leader>j1", function()
      harpoon:list():select(1)
    end, { desc = "Jump: slot 1" })
    vim.keymap.set("n", "<leader>j2", function()
      harpoon:list():select(2)
    end, { desc = "Jump: slot 2" })
    vim.keymap.set("n", "<leader>j3", function()
      harpoon:list():select(3)
    end, { desc = "Jump: slot 3" })
    vim.keymap.set("n", "<leader>j4", function()
      harpoon:list():select(4)
    end, { desc = "Jump: slot 4" })
    vim.keymap.set("n", "<leader>jn", function()
      harpoon:list():next()
    end, { desc = "Jump: next mark" })
    vim.keymap.set("n", "<leader>jp", function()
      harpoon:list():prev()
    end, { desc = "Jump: previous mark" })

    vim.api.nvim_create_user_command("HarpoonQuickMenu", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, {
      desc = "Open Harpoon marks list",
    })
  end,
}
