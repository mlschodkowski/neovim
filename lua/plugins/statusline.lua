return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "echasnovski/mini.icons" },
  config = function()
    local register_labels = {
      ['"'] = "unnamed",
      ['-'] = "small delete",
      ['/'] = "last search",
      ['.'] = "last inserted text",
      [":"] = "last command",
      ["%"] = "current file",
      ["#"] = "alternate file",
      ["*"] = "system clipboard",
      ["+"] = "system clipboard",
      ["0"] = "last yank",
    }

    local function macro_component()
      local recording = vim.fn.reg_recording()
      if recording ~= "" then
        return "REC @" .. recording
      end
      local executing = vim.fn.reg_executing()
      if executing ~= "" then
        return "PLAY @" .. executing
      end
      return ""
    end

    local function register_component()
      local reg = vim.v.register or '"'
      local label = register_labels[reg]
      if not label then
        if reg:match("%d") then
          label = "delete history"
        elseif reg:match("%l") then
          label = "named"
        elseif reg:match("%u") then
          label = "named (append)"
        else
          label = "special"
        end
      end
      return "@" .. reg .. " " .. label
    end

    require("lualine").setup({
      options = {
        icons_enabled = false,
        theme = "auto",
        component_separators = "",
        section_separators = "",
      },

      sections = {
        lualine_a = { "mode", macro_component },
        lualine_b = { "branch" },
        lualine_c = { "filename" },
        lualine_x = {
          register_component,
          function()
            local encoding = vim.o.fileencoding
            if encoding == "" then
              return vim.bo.fileformat .. " :: " .. vim.bo.filetype
            else
              return encoding .. " :: " .. vim.bo.fileformat .. " :: " .. vim.bo.filetype
            end
          end,
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}
