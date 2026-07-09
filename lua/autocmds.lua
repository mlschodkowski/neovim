local api = vim.api

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
  callback = leave_snippet,
})

api.nvim_create_autocmd("FileType", {
  pattern = { "help", "man" },
  command = "wincmd L",
})

api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local dir = vim.fn.expand("<afile>:p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})

api.nvim_create_autocmd("DiagnosticChanged", {
  callback = function()
    vim.diagnostic.setloclist({ open = false })
  end,
})

api.nvim_create_autocmd("VimResized", {
  callback = function()
    vim.cmd("wincmd =")
  end,
})

require("macros")
