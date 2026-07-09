local km = vim.keymap.set

local function ts_move(method, query)
  return function()
    local ok, move = pcall(require, "nvim-treesitter-textobjects.move")
    if ok and move[method] then
      move[method](query)
    end
  end
end

local function get_visual_selection_text()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_row, start_col = start_pos[2] - 1, start_pos[3] - 1
  local end_row, end_col = end_pos[2] - 1, end_pos[3]
  local lines = vim.api.nvim_buf_get_text(0, start_row, start_col, end_row, end_col, {})
  if #lines == 0 then
    return ""
  end
  return table.concat(lines, "\n")
end

local function search_selection(opts)
  local text = get_visual_selection_text()
  if text == "" then
    return
  end
  local escaped = vim.fn.escape(text, [[\/]])
  escaped = escaped:gsub("\n", [[\n]])
  local pattern = opts.word and ([[\V\<%s\>]]):format(escaped) or ([[\V%s]]):format(escaped)
  vim.fn.setreg("/", pattern)
  vim.cmd("normal! " .. (opts.backward and "N" or "n"))
end

local function replace_selection_with_register()
  local reg = vim.v.register
  if reg == "" then
    reg = '"'
  end
  vim.cmd.normal({ '"_d', bang = true })
  vim.cmd.normal({ '"' .. reg .. "P", bang = true })
end

local function select_lines_down()
  local count = vim.v.count1
  vim.cmd("normal! V")
  if count > 1 then
    vim.cmd("normal! " .. (count - 1) .. "j")
  end
end

local function select_lines_up()
  local count = vim.v.count1
  vim.cmd("normal! V")
  if count > 1 then
    vim.cmd("normal! " .. (count - 1) .. "k")
  end
end

local function flatten_document_symbols(items, out)
  out = out or {}
  if not items then
    return out
  end

  for _, item in ipairs(items) do
    local range = item.selectionRange or item.range or (item.location and item.location.range)
    if range then
      table.insert(out, {
        lnum = range.start.line + 1,
        col = range.start.character,
      })
    end
    if item.children then
      flatten_document_symbols(item.children, out)
    end
  end

  return out
end

local function goto_symbol(direction)
  local params = vim.lsp.util.make_position_params()
  local result = vim.lsp.buf_request_sync(0, "textDocument/documentSymbol", params, 1200)
  if not result then
    return
  end

  local symbols = {}
  for _, response in pairs(result) do
    if response.result then
      flatten_document_symbols(response.result, symbols)
    end
  end

  if #symbols == 0 then
    return
  end

  table.sort(symbols, function(a, b)
    if a.lnum == b.lnum then
      return a.col < b.col
    end
    return a.lnum < b.lnum
  end)

  local cur = vim.api.nvim_win_get_cursor(0)
  local cur_line = cur[1]
  local cur_col = cur[2]

  if direction > 0 then
    for _, sym in ipairs(symbols) do
      if sym.lnum > cur_line or (sym.lnum == cur_line and sym.col > cur_col) then
        vim.api.nvim_win_set_cursor(0, { sym.lnum, sym.col })
        return
      end
    end
    vim.api.nvim_win_set_cursor(0, { symbols[1].lnum, symbols[1].col })
    return
  end

  for i = #symbols, 1, -1 do
    local sym = symbols[i]
    if sym.lnum < cur_line or (sym.lnum == cur_line and sym.col < cur_col) then
      vim.api.nvim_win_set_cursor(0, { sym.lnum, sym.col })
      return
    end
  end
  local last = symbols[#symbols]
  vim.api.nvim_win_set_cursor(0, { last.lnum, last.col })
end

-- remaps
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Remove noisy built-in [] mappings so which-key shows only curated dev motions.
for _, lhs in ipairs({
  "]l", "]L", "[l", "[L",
  "]c", "]C", "[c", "[C",
  "]t", "]T", "[t", "[T",
  "]q", "]Q", "[q", "[Q",
  "]n", "]N", "[n", "[N",
}) do
  pcall(vim.keymap.del, "n", lhs)
end

km("n", "<C-h>", "<C-w>h")
km("n", "<C-j>", "<C-w>j")
km("n", "<C-k>", "<C-w>k")
km("n", "<C-l>", "<C-w>l")
km("n", "<C-w>d", "<C-w>c", { desc = "Close current window" })

-- window manips
km("n", "=", [[<cmd>vertical resize +5<cr>]])
km("n", "-", [[<cmd>vertical resize -5<cr>]])
km("n", "+", [[<cmd>horizontal resize +5<cr>]])
km("n", "^", [[<cmd>horizontal resize -5<cr>]])
km("n", "<leader>wv", "<cmd>vsplit<CR>", { desc = "Vertical split" })
km("n", "<leader>wh", "<cmd>split<CR>", { desc = "Horizontal split" })
km("n", "<leader>wc", "<cmd>close<CR>", { desc = "Close window" })
km("n", "<leader>wo", "<cmd>only<CR>", { desc = "Close other windows" })

-- move selections
km("v", "J", ":m '>+1<CR>gv=gv") -- Shift visual selected line down
km("v", "K", ":m '<-2<CR>gv=gv") -- Shift visual selected line up

km("n", "<leader>fm", function()
  require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })
km("n", "<leader>md", "<cmd>OpenInObsidian<CR>", { desc = "Open in Obsidian" })

km("n", "<C-d>", "<C-d>zz")
km("n", "<C-u>", "<C-u>zz")
km("n", "<C-f>", "<C-f>zz")
km("n", "<C-b>", "<C-b>zz")
km("n", "Y", "yy")
km("n", "u", "u", { desc = "Undo" })
km("n", "U", "<C-r>", { desc = "Redo" })
km("n", "n", "nzzzv", { desc = "Next search match" })
km("n", "N", "Nzzzv", { desc = "Previous search match" })
km("n", "/", "/", { desc = "Search forward" })
km("n", "?", "?", { desc = "Search backward" })
km("x", "*", function()
  search_selection({ word = true, backward = false })
end, { desc = "Search selection (word, next)" })
km("x", "#", function()
  search_selection({ word = true, backward = true })
end, { desc = "Search selection (word, previous)" })
km("x", "g*", function()
  search_selection({ word = false, backward = false })
end, { desc = "Search selection (literal, next)" })
km("x", "g#", function()
  search_selection({ word = false, backward = true })
end, { desc = "Search selection (literal, previous)" })
km("n", "m", "v", { desc = "Select textobject (Helix-style)" })
km("x", "R", replace_selection_with_register, { desc = "Replace selection with register" })

-- Helix-like line selection growth
km("n", "x", select_lines_down, { desc = "Select lines down" })
km("x", "x", "j", { desc = "Extend selection down" })
km("n", "X", select_lines_up, { desc = "Select lines up" })
km("x", "X", "k", { desc = "Extend selection up" })
km("x", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
km("x", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- buffers
km("n", "<leader>bb", "<cmd>Telescope buffers<CR>", { desc = "List buffers" })
km("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
km("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
km("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
km("n", "gn", "<cmd>bnext<CR>", { desc = "Go next buffer" })
km("n", "gp", "<cmd>bprevious<CR>", { desc = "Go previous buffer" })
km("n", "<leader>ml", "<cmd>Lazy<CR>", { desc = "Launch Lazy" })
km("n", "<leader>mm", "<cmd>Mason<CR>", { desc = "Launch Mason" })
km("n", "<leader>mu", "<cmd>MasonUpdate<CR>", { desc = "Update Mason registry" })
km("n", "<leader>ms", "<cmd>Lazy sync<CR>", { desc = "Sync plugins" })

-- autocomplete in normal text
km("i", "<C-f>", "<C-x><C-f>", { noremap = true, silent = true })
km("i", "<C-n>", "<C-x><C-n>", { noremap = true, silent = true })
km("i", "<C-l>", "<C-x><C-l>", { noremap = true, silent = true })

-- spell check
km("n", "<leader>ts", "<cmd>setlocal spell! spelllang=en_us<CR>", { desc = "Toggle spellcheck" })
km("n", "<leader>ti", "<cmd>IBLToggle<CR>", { desc = "Toggle indent guides" })
km("n", "<leader>tr", function()
  vim.o.relativenumber = not vim.o.relativenumber
  local state = vim.o.relativenumber and "enabled" or "disabled"
  vim.notify("Relative numbers " .. state)
end, { desc = "Toggle relative numbers" })
km("n", "<leader>tf", function()
  vim.g.disable_autoformat = not vim.g.disable_autoformat
  local state = vim.g.disable_autoformat and "disabled" or "enabled"
  vim.notify("Autoformat " .. state)
end, { desc = "Toggle autoformat" })
km("n", "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle inline blame" })

-- lsp setup
km("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
km("n", "gh", vim.lsp.buf.hover, { desc = "Hover documentation" })
km("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
km("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
km("n", "gO", vim.lsp.buf.document_symbol, { desc = "Document symbols" })
km("n", "gr", vim.lsp.buf.references, { desc = "References" })
km("n", "gi", vim.lsp.buf.implementation, { desc = "Implementations" })
km("n", "grr", vim.lsp.buf.references, { desc = "LSP references" })
km("n", "gri", vim.lsp.buf.implementation, { desc = "LSP implementations" })
km("n", "grn", vim.lsp.buf.rename, { desc = "LSP rename" })
km({ "n", "v" }, "gra", vim.lsp.buf.code_action, { desc = "LSP code actions" })

km({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, { desc = "Code action" })
km("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })

-- see error
km("n", "<leader>de", vim.diagnostic.open_float, { desc = "Line diagnostics" })
km("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Diagnostics to quickfix" })

-- go to next/prev targets
km("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
km("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
km("n", "[s", function()
  goto_symbol(-1)
end, { desc = "Previous symbol" })
km("n", "]s", function()
  goto_symbol(1)
end, { desc = "Next symbol" })
km("n", "[p", "{", { desc = "Previous paragraph" })
km("n", "]p", "}", { desc = "Next paragraph" })
km("n", "]f", ts_move("goto_next_start", { "@function.outer", "@method.outer" }), { desc = "Next function/method start" })
km("n", "[f", ts_move("goto_previous_start", { "@function.outer", "@method.outer" }), { desc = "Previous function/method start" })
km("n", "]t", ts_move("goto_next_start", "@class.outer"), { desc = "Next type/class start" })
km("n", "[t", ts_move("goto_previous_start", "@class.outer"), { desc = "Previous type/class start" })
km("n", "]a", ts_move("goto_next_start", "@parameter.outer"), { desc = "Next argument/parameter start" })
km("n", "[a", ts_move("goto_previous_start", "@parameter.outer"), { desc = "Previous argument/parameter start" })
km("n", "]A", ts_move("goto_next_end", "@parameter.outer"), { desc = "Next argument/parameter end" })
km("n", "[A", ts_move("goto_previous_end", "@parameter.outer"), { desc = "Previous argument/parameter end" })
km("n", "]l", ts_move("goto_next_start", "@loop.outer"), { desc = "Next loop start" })
km("n", "[l", ts_move("goto_previous_start", "@loop.outer"), { desc = "Previous loop start" })
km("n", "]i", ts_move("goto_next_start", "@conditional.outer"), { desc = "Next conditional start" })
km("n", "[i", ts_move("goto_previous_start", "@conditional.outer"), { desc = "Previous conditional start" })
km("n", "]g", "<cmd>Gitsigns next_hunk<CR>", { desc = "Next change" })
km("n", "[g", "<cmd>Gitsigns prev_hunk<CR>", { desc = "Previous change" })
