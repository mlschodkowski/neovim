local M = {}

local state_file = vim.fn.stdpath("state") .. "/colorscheme.txt"
local aliases = {
  ["dark-af"] = "dark_af",
  ["dark af"] = "dark_af",
}

local function normalize_name(name)
  if not name or name == "" then
    return nil
  end
  local trimmed = name:gsub("^%s+", ""):gsub("%s+$", "")
  return aliases[trimmed] or trimmed
end

function M.save(name)
  local normalized = normalize_name(name)
  if not normalized then
    return
  end
  vim.fn.mkdir(vim.fn.fnamemodify(state_file, ":h"), "p")
  vim.fn.writefile({ normalized }, state_file)
end

function M.read()
  if vim.fn.filereadable(state_file) == 0 then
    return nil
  end
  local lines = vim.fn.readfile(state_file)
  return lines[1]
end

function M.apply(name)
  local normalized = normalize_name(name)
  if not normalized then
    return false
  end
  local ok = pcall(vim.cmd.colorscheme, normalized)
  return ok
end

function M.apply_saved_or_default(default_name)
  local saved = normalize_name(M.read())
  local fallback = normalize_name(default_name)
  if saved and M.apply(saved) then
    return saved
  end
  M.apply(fallback)
  return fallback
end

return M
