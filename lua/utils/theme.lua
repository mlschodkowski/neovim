local M = {}

local state_file = vim.fn.stdpath("state") .. "/colorscheme.txt"

function M.save(name)
  if not name or name == "" then
    return
  end
  vim.fn.mkdir(vim.fn.fnamemodify(state_file, ":h"), "p")
  vim.fn.writefile({ name }, state_file)
end

function M.read()
  if vim.fn.filereadable(state_file) == 0 then
    return nil
  end
  local lines = vim.fn.readfile(state_file)
  return lines[1]
end

function M.apply(name)
  if not name or name == "" then
    return false
  end
  local ok = pcall(vim.cmd.colorscheme, name)
  return ok
end

function M.apply_saved_or_default(default_name)
  local saved = M.read()
  if saved and M.apply(saved) then
    return saved
  end
  M.apply(default_name)
  return default_name
end

return M
