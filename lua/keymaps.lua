local function notify_quiet(message, level)
  vim.notify(message, level or vim.log.levels.INFO, { title = "Keymap" })
end

local function km(mode, lhs, rhs, opts)
  if type(rhs) == "function" then
    local original_rhs = rhs
    rhs = function(...)
      local ok, err = pcall(original_rhs, ...)
      if not ok then
        local short_err = tostring(err):gsub("\n.*", "")
        notify_quiet(("Mapping %s failed: %s"):format(lhs, short_err), vim.log.levels.WARN)
      end
    end
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

local function ts_move(method, query)
  return function()
    local ok, move = pcall(require, "nvim-treesitter-textobjects.move")
    if not ok then
      notify_quiet("Treesitter textobjects move module is unavailable")
      return
    end
    if not move[method] then
      notify_quiet(("Treesitter move method is unavailable: %s"):format(method))
      return
    end
    move[method](query)
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
    notify_quiet("No visual selection to search")
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
    notify_quiet("No LSP response for document symbols")
    return
  end

  local symbols = {}
  for _, response in pairs(result) do
    if response.result then
      flatten_document_symbols(response.result, symbols)
    end
  end

  if #symbols == 0 then
    notify_quiet("No symbols found in current buffer")
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

local function push_jump()
  vim.cmd("normal! m'")
end

local function with_jump(fn)
  return function()
    push_jump()
    fn()
  end
end

local function is_visual_mode()
  local mode = vim.fn.mode()
  return mode == "v" or mode == "V" or mode == "\22"
end

local function get_visual_range()
  if not is_visual_mode() then
    return nil
  end
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local sr, sc = start_pos[2] - 1, start_pos[3] - 1
  local er, ec = end_pos[2] - 1, end_pos[3]
  if sr > er or (sr == er and sc > ec) then
    sr, er = er, sr
    sc, ec = ec - 1, sc + 1
  end
  return { sr, sc, er, ec }
end

local function apply_visual_range(range)
  vim.api.nvim_win_set_cursor(0, { range[1] + 1, range[2] })
  vim.cmd("normal! v")
  vim.api.nvim_win_set_cursor(0, { range[3] + 1, math.max(range[4] - 1, 0) })
end

local function get_node_at_pos(pos)
  local ok_node, node = pcall(vim.treesitter.get_node, { bufnr = 0, pos = pos, ignore_injections = false })
  if ok_node and node then
    return node
  end

  local ok_parser, parser = pcall(vim.treesitter.get_parser, 0)
  if not ok_parser or not parser then
    return nil
  end
  local tree = parser:parse()[1]
  if not tree then
    return nil
  end
  return tree:root():named_descendant_for_range(pos[1], pos[2], pos[1], pos[2])
end

local function range_contains(outer, inner)
  local starts_before = outer[1] < inner[1] or (outer[1] == inner[1] and outer[2] <= inner[2])
  local ends_after = outer[3] > inner[3] or (outer[3] == inner[3] and outer[4] >= inner[4])
  return starts_before and ends_after
end

local function same_range(a, b)
  return a[1] == b[1] and a[2] == b[2] and a[3] == b[3] and a[4] == b[4]
end

local generic_text_nodes = {
  block = true,
  body = true,
  chunk = true,
  document = true,
  paragraph = true,
  program = true,
  root = true,
  section = true,
  source_file = true,
  text = true,
}

local function select_current_word()
  vim.cmd("normal! viw")
end

local function symbol_ranges_from_cursor_or_selection()
  local visual = get_visual_range()
  local pos
  if visual then
    pos = { visual[1], visual[2] }
  else
    local cur = vim.api.nvim_win_get_cursor(0)
    pos = { cur[1] - 1, cur[2] }
  end

  local node = get_node_at_pos(pos)
  if not node then
    return nil, visual
  end

  local ranges = {}
  while node do
    local sr, sc, er, ec = node:range()
    local candidate = { sr, sc, er, ec }
    if (not visual) or range_contains(candidate, visual) then
      local last = ranges[#ranges]
      if not last or not same_range(last, candidate) then
        table.insert(ranges, candidate)
      end
    end
    node = node:parent()
  end

  return ranges, visual
end

local function expand_symbol_selection()
  local ranges, visual = symbol_ranges_from_cursor_or_selection()
  if not ranges or #ranges == 0 then
    notify_quiet("No syntax symbol found at cursor")
    return
  end

  if not visual then
    local node = get_node_at_pos({ vim.api.nvim_win_get_cursor(0)[1] - 1, vim.api.nvim_win_get_cursor(0)[2] })
    if node and generic_text_nodes[node:type()] then
      select_current_word()
      return
    end
  end

  local target = ranges[1]
  if visual then
    for idx, range in ipairs(ranges) do
      if same_range(range, visual) then
        target = ranges[math.min(idx + 1, #ranges)]
        break
      end
      if range_contains(range, visual) then
        target = range
        break
      end
    end
  end

  apply_visual_range(target)
end

local function collapse_selection()
  if is_visual_mode() then
    vim.cmd("normal! <Esc>")
    return
  end
  notify_quiet("No active selection to collapse")
end

local function select_entire_buffer()
  vim.cmd("normal! gg0vG$")
end

local function format_buffer()
  require("conform").format({ async = true, lsp_format = "fallback" })
end

-- Core mappings
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

-- Window size and split controls
km("n", "=", [[<cmd>vertical resize +5<cr>]])
km("n", "-", [[<cmd>vertical resize -5<cr>]])
km("n", "+", [[<cmd>horizontal resize +5<cr>]])
km("n", "^", [[<cmd>horizontal resize -5<cr>]])
km("n", "<leader>wv", "<cmd>vsplit<CR>", { desc = "Vertical split" })
km("n", "<leader>wh", "<cmd>split<CR>", { desc = "Horizontal split" })
km("n", "<leader>wc", "<cmd>close<CR>", { desc = "Close window" })
km("n", "<leader>wo", "<cmd>only<CR>", { desc = "Close other windows" })

-- Move selected lines
km("v", "J", ":m '>+1<CR>gv=gv") -- Shift visual selected line down
km("v", "K", ":m '<-2<CR>gv=gv") -- Shift visual selected line up

km("n", "<C-d>", "<C-d>zz")
km("n", "<C-u>", "<C-u>zz")
km("n", "<C-f>", "<C-f>zz")
km("n", "<C-b>", "<C-b>zz")
km("n", "<C-s>", push_jump, { desc = "Save position to jumplist" })
km("n", "<leader>jm", push_jump, { desc = "Save position to jumplist" })
km("n", "<C-o>", "<C-o>", { desc = "Jumplist back", noremap = true })
km("n", "<C-i>", "<C-i>", { desc = "Jumplist forward", noremap = true })
km("n", "Y", "yy")
km("n", "u", "u", { desc = "Undo" })
km("n", "U", "<C-r>", { desc = "Redo" })
km("n", "<C-c>", "gcc", { remap = true, desc = "Toggle comment line" })
km("x", "<C-c>", "gc", { remap = true, desc = "Toggle comment selection" })
-- Shift-< and Shift-> arrive in Neovim as the literal angle-bracket keys.
km("n", "<lt>", "<<", { desc = "Indent left" })
km("n", ">", ">>", { desc = "Indent right" })
km("x", "<lt>", "<gv", { desc = "Indent left (keep selection)" })
km("x", ">", ">gv", { desc = "Indent right (keep selection)" })
km("n", "n", "nzzzv", { desc = "Next search match" })
km("n", "N", "Nzzzv", { desc = "Previous search match" })
km("n", ".", ";", { desc = "Repeat last movement" })
km({ "n", "x" }, "s", expand_symbol_selection, { desc = "Helix-style selection" })
km("n", ";", collapse_selection, { desc = "Collapse selection" })
km("x", ";", "<Esc>", { desc = "Collapse selection", noremap = true, silent = true, nowait = true })
km({ "n", "x" }, "%", select_entire_buffer, { desc = "Select whole buffer" })
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
km("n", "x", "x", { desc = "Delete character" })
km("n", "X", "X", { desc = "Delete character before cursor" })
km("n", "v", select_lines_down, { desc = "Select lines down" })
km("n", "V", select_lines_up, { desc = "Select lines up" })
km("x", "v", "j", { desc = "Extend line selection down" })
km("x", "V", "k", { desc = "Extend line selection up" })
km("x", "x", "j", { desc = "Extend selection down" })
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
km("n", "<leader>ml", "<cmd>Lazy<CR>", { desc = "Open Lazy" })
km("n", "<leader>mm", "<cmd>Mason<CR>", { desc = "Open Mason" })
km("n", "<leader>mu", "<cmd>MasonUpdate<CR>", { desc = "Update Mason registry" })
km("n", "<leader>ms", "<cmd>Lazy sync<CR>", { desc = "Sync plugins" })

-- Insert mode completion
km("i", "<C-f>", "<C-x><C-f>", { noremap = true, silent = true })
km("i", "<C-n>", "<C-x><C-n>", { noremap = true, silent = true })
km("i", "<C-l>", "<C-x><C-l>", { noremap = true, silent = true })

-- Toggle helpers
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
km("n", "<leader>td", "<cmd>ToggleInlineDiagnostics<CR>", { desc = "Toggle inline diagnostics" })
km("n", "<leader>tb", function()
  require("gitsigns").toggle_current_line_blame()
end, { desc = "Toggle inline blame" })

-- LSP mappings
km("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
km("n", "gh", vim.lsp.buf.hover, { desc = "Hover documentation" })
km("n", "gd", with_jump(function()
  require("telescope.builtin").lsp_definitions()
end), { desc = "Go to definition" })
km("n", "gD", with_jump(function()
  require("telescope.builtin").lsp_declarations()
end), { desc = "Go to declaration" })
km("n", "gO", vim.lsp.buf.document_symbol, { desc = "Document symbols" })
km("n", "gr", with_jump(function()
  require("telescope.builtin").lsp_references({ include_declaration = false })
end), { desc = "References" })
km("n", "gi", with_jump(function()
  require("telescope.builtin").lsp_implementations()
end), { desc = "Implementations" })
km("n", "grr", with_jump(function()
  require("telescope.builtin").lsp_references({ include_declaration = false })
end), { desc = "LSP references" })
km("n", "gri", with_jump(function()
  require("telescope.builtin").lsp_implementations()
end), { desc = "LSP implementations" })
km("n", "grn", vim.lsp.buf.rename, { desc = "LSP rename" })
km({ "n", "v" }, "gra", vim.lsp.buf.code_action, { desc = "LSP code actions" })

-- Unified LSP/refactor leader mappings.
km({ "n", "v" }, "<leader>ra", vim.lsp.buf.code_action, { desc = "Code action" })
km("n", "<leader>rr", vim.lsp.buf.rename, { desc = "Rename symbol" })
km("n", "<leader>rf", format_buffer, { desc = "Format buffer" })

-- Diagnostics helpers
km("n", "<leader>de", vim.diagnostic.open_float, { desc = "Line diagnostics" })
km("n", "<leader>dc", "<cmd>CursorDiagnostics<CR>", { desc = "Cursor diagnostics" })
km("n", "<leader>dh", "<cmd>HoverDoc<CR>", { desc = "Hover docs under cursor" })
km("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Diagnostics to quickfix" })

-- Next/previous navigation targets
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
