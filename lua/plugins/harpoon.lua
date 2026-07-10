return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    local telescope_ok, pickers = pcall(require, "telescope.pickers")
    local finders = telescope_ok and require("telescope.finders") or nil
    local conf = telescope_ok and require("telescope.config").values or nil

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
    local function telescope_marks()
      if not telescope_ok then
        vim.notify("Telescope is not available", vim.log.levels.WARN)
        return
      end

      local items = harpoon:list().items or {}
      if #items == 0 then
        vim.notify("Harpoon list is empty", vim.log.levels.INFO)
        return
      end

      local entries = {}
      for idx, item in ipairs(items) do
        local path = item.value or item.filename or item.path
        if path and path ~= "" then
          table.insert(entries, {
            idx = idx,
            path = path,
          })
        end
      end

      if #entries == 0 then
        vim.notify("Harpoon list has no valid file entries", vim.log.levels.INFO)
        return
      end

      pickers.new({}, {
        prompt_title = "Harpoon marks",
        finder = finders.new_table({
          results = entries,
          entry_maker = function(entry)
            local rel = vim.fn.fnamemodify(entry.path, ":~:.")
            return {
              value = entry,
              ordinal = rel,
              display = string.format("%d. %s", entry.idx, rel),
              path = entry.path,
              filename = entry.path,
            }
          end,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.file_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
          local actions = require("telescope.actions")
          local action_state = require("telescope.actions.state")

          local function open_entry()
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            if selection and selection.path then
              vim.cmd("edit " .. vim.fn.fnameescape(selection.path))
            end
          end

          map("i", "<CR>", open_entry)
          map("n", "<CR>", open_entry)
          return true
        end,
      }):find()
    end

    vim.keymap.set("n", "<leader>jj", function()
      telescope_marks()
    end, { desc = "Jump: open marks list (preview)" })
    vim.keymap.set("n", "<leader>jJ", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Jump: open quick menu" })
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
      telescope_marks()
    end, {
      desc = "Open Harpoon marks list with preview",
    })
  end,
}
