local M = {}

local function line_text(filename, lnum)
  if not filename or filename == "" or vim.fn.filereadable(filename) == 0 then
    return "[file unavailable]"
  end
  local lines = vim.fn.readfile(filename, "", lnum)
  local line = lines[lnum] or ""
  return line:gsub("^%s+", ""):gsub("%s+$", "")
end

function M.pick()
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local entry_display = require("telescope.pickers.entry_display")
  local finders = require("telescope.finders")
  local pickers = require("telescope.pickers")
  local sorters = require("telescope.sorters")
  local jumplist = vim.fn.getjumplist()[1]
  local entries = {}

  for _, item in ipairs(jumplist) do
    local filename = item.filename or vim.api.nvim_buf_get_name(item.bufnr)
    if filename and filename ~= "" then
      table.insert(entries, {
        filename = filename,
        lnum = item.lnum,
        col = item.col,
        text = line_text(filename, item.lnum),
      })
    end
  end

  local displayer = entry_display.create({
    separator = "  ",
    items = {
      { width = 38 },
      { width = 7 },
      { remaining = true },
    },
  })

  pickers.new({}, {
    prompt_title = "Jump history",
    finder = finders.new_table({
      results = entries,
      entry_maker = function(entry)
        local path = vim.fn.fnamemodify(entry.filename, ":~:.")
        entry.display = function()
          return displayer({ path, string.format(":%d", entry.lnum), entry.text })
        end
        entry.ordinal = table.concat({ path, entry.text, tostring(entry.lnum) }, " ")
        return entry
      end,
    }),
    sorter = sorters.get_generic_fuzzy_sorter(),
    previewer = require("telescope.config").values.file_previewer({}),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if selection then
          vim.cmd.edit(vim.fn.fnameescape(selection.filename))
          vim.api.nvim_win_set_cursor(0, { selection.lnum, selection.col })
        end
      end)
      return true
    end,
  }):find()
end

return M
