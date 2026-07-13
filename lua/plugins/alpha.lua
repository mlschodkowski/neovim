return {
  "goolord/alpha-nvim",
  dependencies = {
    "echasnovski/mini.icons",
  },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    local section = dashboard.section

    local function get_branch()
      local cwd = vim.fn.getcwd()
      local branch = vim.fn.systemlist({ "git", "-C", cwd, "rev-parse", "--abbrev-ref", "HEAD" })[1]
      if vim.v.shell_error ~= 0 or not branch or branch == "" then
        return "-"
      end
      return branch
    end

    local function recents_lines(limit)
      local lines = {}
      local seen = {}
      for _, path in ipairs(vim.v.oldfiles or {}) do
        if #lines >= limit then
          break
        end
        if path and path ~= "" and vim.fn.filereadable(path) == 1 and not seen[path] then
          seen[path] = true
          table.insert(lines, string.format("%d. %s", #lines + 1, vim.fn.fnamemodify(path, ":~:.")))
        end
      end
      if #lines == 0 then
        return { "No recent files yet." }
      end
      return lines
    end

    section.header.val = {
      [[  ______________________]],
      [[ /\                     \]],
      [[/  \    _________________\]],
      [[\   \   \                /]],
      [[ \   \   \__________    /]],
      [[  \   \   \    /   /   /]],
      [[   \   \   \  /   /   /]],
      [[    \   \   \/   /   /]],
      [[     \   \  /   /   /]],
      [[      \   \/   /   /]],
      [[       \      /   /]],
      [[        \    /   /]],
      [[         \  /   /]],
      [[          \/___/]],
    }
    section.header.opts.hl = "Comment"

    local context = {
      type = "text",
      val = {
        ("cwd: %s"):format(vim.fn.fnamemodify(vim.fn.getcwd(), ":~")),
        ("branch: %s"):format(get_branch()),
      },
      opts = {
        position = "center",
        hl = "Comment",
      },
    }

    local work_title = {
      type = "text",
      val = "WORK",
      opts = {
        position = "center",
        hl = "Keyword",
      },
    }

    local work_buttons = {
      dashboard.button("f", "[f] files", ":ProjectFiles<CR>"),
      dashboard.button("g", "[g] grep", ":ProjectGrep<CR>"),
      dashboard.button("p", "[p] projects", ":Telescope projects<CR>"),
      dashboard.button("r", "[r] recents", ":Telescope oldfiles<CR>"),
    }

    local git_title = {
      type = "text",
      val = "GIT",
      opts = {
        position = "center",
        hl = "Keyword",
      },
    }

    local git_buttons = {
      dashboard.button("s", "[s] status", ":Telescope git_status<CR>"),
      dashboard.button("b", "[b] branches", ":Telescope git_branches<CR>"),
    }

    local tools_title = {
      type = "text",
      val = "TOOLS",
      opts = {
        position = "center",
        hl = "Keyword",
      },
    }

    local tool_buttons = {
      dashboard.button("y", "[y] yazi", ":Yazi cwd<CR>"),
      dashboard.button("j", "[j] bookmarks", ":Telescope lspmark<CR>"),
      dashboard.button("c", "[c] reload config", ":ConfigReload<CR>"),
      dashboard.button("q", "[q] quit", ":qa<CR>"),
    }

    section.buttons.val = {}
    vim.list_extend(section.buttons.val, work_buttons)
    vim.list_extend(section.buttons.val, git_buttons)
    vim.list_extend(section.buttons.val, tool_buttons)

    local hints = {
      type = "text",
      val = "[f] files  [g] grep  [p] projects  [r] recents  [s] status  [b] branches  [j] bookmarks",
      opts = {
        position = "center",
        hl = "Comment",
      },
    }

    local recents_title = {
      type = "text",
      val = "RECENT FILES",
      opts = {
        position = "center",
        hl = "Keyword",
      },
    }

    local recents = {
      type = "text",
      val = recents_lines(5),
      opts = {
        position = "center",
        hl = "Comment",
      },
    }

    local lazy_stats = require("lazy").stats()
    section.footer.val = {
      ("startup: %.1fms | plugins: %d"):format(lazy_stats.startuptime or 0, lazy_stats.count or 0),
    }
    section.footer.opts.hl = "Comment"

    dashboard.config.layout = {
      { type = "padding", val = 1 },
      section.header,
      { type = "padding", val = 1 },
      context,
      { type = "padding", val = 1 },
      work_title,
      { type = "padding", val = 1 },
      { type = "group", val = work_buttons, opts = { spacing = 0 } },
      { type = "padding", val = 1 },
      git_title,
      { type = "padding", val = 1 },
      { type = "group", val = git_buttons, opts = { spacing = 0 } },
      { type = "padding", val = 1 },
      tools_title,
      { type = "padding", val = 1 },
      { type = "group", val = tool_buttons, opts = { spacing = 0 } },
      { type = "padding", val = 1 },
      hints,
      { type = "padding", val = 1 },
      recents_title,
      recents,
      { type = "padding", val = 1 },
      section.footer,
    }

    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)
  end,
}
