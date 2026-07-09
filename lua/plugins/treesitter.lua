---@module "lazy"
---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-context",
      opts = {
        max_lines = 4,
        multiline_threshold = 2,
      },
    },
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")
    local parsers = {
      "bash",
      "c",
      "css",
      "go",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "python",
      "rust",
      "sql",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    }

    ts.install(parsers, { max_jobs = 8 })
    require("nvim-treesitter-textobjects").setup({
      move = {
        set_jumps = true,
      },
    })

    local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      callback = function(event)
        local lang = vim.treesitter.language.get_lang(event.match) or event.match
        pcall(vim.treesitter.start, event.buf, lang)
        vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
