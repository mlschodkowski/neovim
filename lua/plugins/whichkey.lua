return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    filter = function(mapping)
      if mapping.plugin then
        return true
      end
      if mapping.group then
        return true
      end
      return mapping.desc and mapping.desc ~= ""
    end,
    plugins = {
      marks = false,
      registers = true,
      spelling = {
        enabled = false,
      },
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = false,
        nav = false,
        z = false,
        g = false,
      },
    },
    win = {
      padding = { 1, 2 },
      title = false,
      border = "rounded",
    },
    icons = {
      breadcrumb = ">",
      separator = "  ",
      group = ">",
      mappings = true,
      colors = false,
      rules = {},
      keys = {},
    },
    layout = {
      width = { min = 24 },
      spacing = 2,
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    -- Make register hints concise and easier to scan:
    -- <name> <description> <short content>
    pcall(function()
      local plugins = require("which-key.plugins")
      local registers = require("which-key.plugins.registers")

      vim.api.nvim_set_hl(0, "WhichKeyRegDesc", { link = "WhichKeyDesc" })
      vim.api.nvim_set_hl(0, "WhichKeyRegValue", { link = "WhichKeyValue" })

      local original_cols = plugins.cols
      plugins.cols = function(name)
        if name == "registers" then
          return {
            { key = "rdesc", hl = "WhichKeyRegDesc", width = 0.35 },
            { key = "rcontent", hl = "WhichKeyRegValue", width = 0.65 },
          }
        end
        return original_cols(name)
      end

      local original_expand = registers.expand
      registers.expand = function()
        local items = original_expand()
        local by_key = {}

        for _, item in ipairs(items) do
          by_key[item.key] = item
        end

        local function ensure_register(key, desc, fallback_value)
          if by_key[key] then
            return
          end
          local value = fallback_value or ""
          if key == "+" or key == "*" then
            if vim.g.loaded_clipboard_provider == 2 then
              local ok, reg_value = pcall(vim.fn.getreg, key, 1)
              value = ok and reg_value or ""
              if value == "" then
                value = "(empty)"
              end
            else
              value = "(clipboard unavailable)"
            end
          end
          local item = {
            key = key,
            desc = desc,
            value = value,
          }
          table.insert(items, item)
          by_key[key] = item
        end

        ensure_register("_", "black hole", "(discard only)")
        ensure_register("+", "system clipboard")
        ensure_register("*", "selection clipboard")

        table.sort(items, function(a, b)
          return a.key < b.key
        end)

        for _, item in ipairs(items) do
          local value = (item.value or ""):gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
          local label = (item.desc and item.desc ~= "") and item.desc or "register"

          if #label > 18 then
            label = label:sub(1, 18) .. "…"
          end
          if #value > 30 then
            value = value:sub(1, 30) .. "…"
          end

          item.rdesc = label
          item.rcontent = value
          item.desc = ""
          item.value = ""
        end
        return items
      end
    end)

    wk.add({
      { "g", group = "Goto" },
      { "gr", group = "LSP" },
      { "<leader>b", group = "Buffer" },
      { "<leader>f", group = "Find" },
      { "<leader>h", group = "Help" },
      { "<leader>m", group = "Manage" },
      { "<leader>e", group = "Explorer" },
      { "<leader>y", group = "Yazi" },
      { "<leader>w", group = "Window" },
      { "<leader>d", group = "Diagnostics" },
      { "<leader>g", group = "Git" },
      { "<leader>t", group = "Toggle" },
      { "<leader>r", group = "Refactor" },
    })
  end,
  keys = {
    {
      "<leader>?",
      function()
        require("telescope.builtin").keymaps({
          show_plug = false,
          modes = { "n", "x", "i", "t" },
        })
      end,
      desc = "Keymap search",
    },
    {
      "<leader>K",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "Keymap groups",
    },
    {
      "<leader>:",
      function()
        require("telescope.builtin").command_history()
      end,
      desc = "Command history",
    },
  },
}
