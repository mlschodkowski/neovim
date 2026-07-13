local api = vim.api
local group = api.nvim_create_augroup("UserAutocmds", { clear = true })

local function leave_snippet()
  local ok, luasnip = pcall(require, "luasnip")
  if not ok then
    return
  end

  local was_insert_or_snippet = vim.v.event.old_mode == "i"
    or (vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n")

  if not was_insert_or_snippet then
    return
  end

  local buf = api.nvim_get_current_buf()
  if luasnip.session.current_nodes[buf] and not luasnip.session.jump_active then
    luasnip.unlink_current()
  end
end

api.nvim_create_autocmd("ModeChanged", {
  group = group,
  callback = leave_snippet,
})

api.nvim_create_autocmd("VimResized", {
  group = group,
  callback = function()
    vim.cmd("wincmd =")
  end,
})

require("macros")
