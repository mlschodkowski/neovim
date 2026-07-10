-- telescope.nvim
return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    -- branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    config = function()
      local actions = require("telescope.actions")

      -- Compatibility for telescope previewers expecting legacy nvim-treesitter APIs.
      if not package.loaded["nvim-treesitter.configs"] then
        package.preload["nvim-treesitter.configs"] = function()
          local ok_cfg, ts_config = pcall(require, "nvim-treesitter.config")
          if not ok_cfg then
            return {
              is_enabled = function()
                return false
              end,
              get_module = function()
                return {}
              end,
            }
          end

          return {
            is_enabled = function(module, lang, _)
              if module ~= "highlight" then
                return false
              end
              local installed = ts_config.get_installed and ts_config.get_installed("parsers") or {}
              return vim.tbl_contains(installed, lang)
            end,
            get_module = function(module)
              if module == "highlight" then
                return { additional_vim_regex_highlighting = false }
              end
              return {}
            end,
          }
        end
      end

      local ok_parsers, parsers = pcall(require, "nvim-treesitter.parsers")
      if ok_parsers and parsers and not parsers.ft_to_lang then
        parsers.ft_to_lang = function(ft)
          local ok_lang, lang = pcall(vim.treesitter.language.get_lang, ft)
          if ok_lang then
            return lang
          end
          return ft
        end
      end
      if ok_parsers and parsers and not parsers.get_parser then
        parsers.get_parser = function(bufnr, lang)
          return vim.treesitter.get_parser(bufnr, lang)
        end
      end

      require("telescope").setup({
        defaults = {
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            prompt_position = "top",
          },
          color_devicons = false,
          prompt_prefix = "> ",
          selection_caret = "> ",
          results_title = false,
          preview_title = false,
          initial_mode = "insert",
          mappings = {
            i = {
              ["<Esc>"] = actions.close,
              ["<C-c>"] = actions.close,
              ["<C-r>"] = function()
                require("which-key").show({
                  keys = "<C-r>",
                  mode = "i",
                })
              end,
            },
            n = {
              ["<Esc>"] = actions.close,
              ["<C-c>"] = actions.close,
            },
          },
          preview = {
            treesitter = false,
          },
          borderchars = {
            prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
            preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
        pickers = {
          colorscheme = {
            enable_preview = true,
          },
        },
      })

      require("telescope").load_extension("fzf")

      -- telescope setup
      local builtin = require("telescope.builtin")
      local theme = require("utils.theme")
      local action_state = require("telescope.actions.state")
      local entry_display = require("telescope.pickers.entry_display")
      local make_entry = require("telescope.make_entry")
      local sorters = require("telescope.sorters")
      local telescope_themes = require("telescope.themes")
      local common_ignore_globs = {
        "!.git/*",
        "!node_modules/*",
        "!.venv/*",
        "!venv/*",
        "!__pycache__/*",
        "!dist/*",
        "!build/*",
        "!target/*",
      }

      local function open_selected_file(prompt_bufnr)
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if not entry or not entry.value then
          return
        end

        vim.schedule(function()
          vim.cmd.edit(vim.fn.fnameescape(entry.path or entry.value))
        end)
      end

      local function open_files_in_buffer()
        return function(_, map)
          map("i", "<Esc>", actions.close)
          map("n", "<Esc>", actions.close)
          map("i", "<CR>", open_selected_file)
          map("n", "<CR>", open_selected_file)
          return true
        end
      end

      local function find_files_ignored()
        local find_command = { "rg", "--files", "--hidden" }
        for _, glob in ipairs(common_ignore_globs) do
          table.insert(find_command, "--glob")
          table.insert(find_command, glob)
        end
        builtin.find_files({
          hidden = true,
          find_command = find_command,
          attach_mappings = open_files_in_buffer(),
        })
      end

      local function normalize_extension(raw)
        if not raw then
          return nil
        end
        local ext = raw:gsub("^%s+", ""):gsub("%s+$", "")
        if ext == "" then
          return nil
        end
        ext = ext:gsub("^%*?%.", "")
        return ext ~= "" and ext or nil
      end

      local function find_files_by_extension(ext)
        local normalized = normalize_extension(ext)
        if not normalized then
          vim.notify("Extension is required, example: lua", vim.log.levels.WARN)
          return
        end

        local find_command = { "rg", "--files", "--hidden", "--glob", "*." .. normalized }
        for _, glob in ipairs(common_ignore_globs) do
          table.insert(find_command, "--glob")
          table.insert(find_command, glob)
        end

        builtin.find_files({
          prompt_title = "files *." .. normalized,
          hidden = true,
          find_command = find_command,
          attach_mappings = open_files_in_buffer(),
        })
      end

      local function live_grep_ignored()
        builtin.live_grep({
          attach_mappings = open_files_in_buffer(),
          additional_args = function()
            local args = {}
            for _, glob in ipairs(common_ignore_globs) do
              table.insert(args, "--glob")
              table.insert(args, glob)
            end
            return args
          end,
        })
      end

      local function help_live_grep()
        local doc_dirs = {}
        for _, rtp in ipairs(vim.api.nvim_list_runtime_paths()) do
          local doc_dir = rtp .. "/doc"
          if vim.fn.isdirectory(doc_dir) == 1 then
            table.insert(doc_dirs, doc_dir)
          end
        end
        builtin.live_grep({
          prompt_title = "help grep",
          search_dirs = doc_dirs,
          glob_pattern = "*.txt",
        })
      end

      local function command_palette()
        local leader = vim.g.mapleader or "\\"
        local seen = {}
        local entries = {}

        local function is_leader_map(lhs)
          if not lhs or lhs == "" then
            return false
          end
          local lower = lhs:lower()
          if lower:find("^<leader>") then
            return true
          end
          if leader == " " then
            return lhs:find("^<Space>") or lhs:sub(1, 1) == " "
          end
          return lhs:sub(1, #leader) == leader
        end

        local function display_lhs(lhs)
          if not lhs or lhs == "" then
            return ""
          end
          local normalized = lhs:gsub("^<Leader>", "<leader>")
          if leader == " " then
            normalized = normalized:gsub("^<Space>", "<leader>", 1):gsub("^ ", "<leader>", 1)
          else
            normalized = normalized:gsub("^" .. vim.pesc(leader), "<leader>", 1)
          end
          return normalized
        end

        local function leader_group_from_keybinding(keybinding)
          if not keybinding:find("^<leader>") then
            return nil
          end
          local tail = keybinding:sub(#"<leader>" + 1)
          if tail == "" then
            return nil
          end
          if tail:sub(1, 1) == "<" then
            local token = tail:match("^<[^>]+>")
            return token or tail
          end
          return tail:sub(1, 1)
        end

        local function leader_group_rank(group)
          if not group or group == "" then
            return 2
          end
          if group:match("^[%a%d]$") then
            return 0
          end
          return 1
        end

        local function command_prefix_rank(command)
          if type(command) == "string" and command:sub(1, 1) == ":" then
            return 1
          end
          return 0
        end

        local function command_text(map)
          local rhs = (map.rhs or ""):gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
          if rhs ~= "" then
            local cmd = rhs:match("^<[Cc][Mm][Dd]>(.-)<[Cc][Rr]>$")
            if cmd and cmd ~= "" then
              return ":" .. cmd
            end
            return rhs
          end

          if map.desc and map.desc ~= "" then
            return map.desc
          end

          if map.callback then
            local info = debug.getinfo(map.callback, "S")
            local source = info and info.source or ""
            if source:sub(1, 1) == "@" then
              source = source:sub(2)
            end
            local cwd = vim.uv.cwd() or ""
            if cwd ~= "" then
              source = source:gsub("^" .. vim.pesc(cwd .. "/"), "")
            end
            local line = (info and info.linedefined) or 0
            if source ~= "" then
              return string.format("lua:%s:%d", source, line)
            end
            return "lua:callback"
          end

          return "[mapping]"
        end

        local function add_maps(maps)
          for _, map in ipairs(maps or {}) do
            local lhs = map.lhs or ""
            if is_leader_map(lhs) then
              local key = table.concat({ map.mode or "n", lhs, map.rhs or "", map.desc or "" }, "\0")
              if not seen[key] then
                seen[key] = true
                local command = command_text(map)
                local keybinding = display_lhs(lhs)
                local description = map.desc or ""
                table.insert(entries, {
                  kind = "mapping",
                  lhs = lhs,
                  command = command,
                  keybinding = keybinding,
                  leader_group = leader_group_from_keybinding(keybinding),
                  description = description,
                  ordinal = table.concat({
                    command,
                    keybinding,
                    description,
                    lhs,
                    map.rhs or "",
                  }, " "),
                })
              end
            end
          end
        end

        local function add_commands(commands)
          for name, command in pairs(commands or {}) do
            local ex = ":" .. name
            local description = command.desc or command.definition or ""
            local key = table.concat({ "cmd", name, description }, "\0")
            if not seen[key] then
              seen[key] = true
              table.insert(entries, {
                kind = "command",
                ex_cmd = name,
                command = ex,
                keybinding = "",
                description = description,
                ordinal = table.concat({ ex, description }, " "),
              })
            end
          end
        end

        add_maps(vim.api.nvim_get_keymap("n"))
        add_maps(vim.api.nvim_buf_get_keymap(0, "n"))
        add_commands(vim.api.nvim_get_commands({ builtin = false }))
        add_commands(vim.api.nvim_buf_get_commands(0, { builtin = false }))

        if vim.tbl_isempty(entries) then
          vim.notify("No <leader> mappings found", vim.log.levels.WARN)
          return
        end

        table.sort(entries, function(a, b)
          local ac = command_prefix_rank(a.command)
          local bc = command_prefix_rank(b.command)
          if ac ~= bc then
            return ac < bc
          end

          if a.kind ~= b.kind then
            return a.kind == "mapping"
          end
          if a.kind == "mapping" then
            local ar = leader_group_rank(a.leader_group)
            local br = leader_group_rank(b.leader_group)
            if ar ~= br then
              return ar < br
            end
            local ag = a.leader_group or "~"
            local bg = b.leader_group or "~"
            if ag ~= bg then
              return ag < bg
            end
          end
          if a.keybinding == b.keybinding then
            return a.command < b.command
          end
          return a.keybinding < b.keybinding
        end)

        local displayer = entry_display.create({
          separator = "  ",
          items = {
            { width = 40 },
            { width = 18 },
            { remaining = true },
          },
        })

        local function make_display(entry)
          return displayer({ entry.command, entry.keybinding, entry.description })
        end

        local opts = {
          prompt_title = "Command palette (<leader>)",
          finder = require("telescope.finders").new_table({
            results = entries,
            entry_maker = function(entry)
              entry.display = make_display
              return entry
            end,
          }),
          sorter = sorters.fuzzy_with_index_bias({}),
          previewer = false,
          attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
              local selection = action_state.get_selected_entry()
              actions.close(prompt_bufnr)
              if not selection then
                return
              end
              if selection.kind == "command" and selection.ex_cmd then
                vim.cmd(selection.ex_cmd)
                return
              end
              if selection.lhs then
                local keys = vim.api.nvim_replace_termcodes(selection.lhs, true, false, true)
                vim.api.nvim_feedkeys(keys, "m", false)
              end
            end)
            return true
          end,
        }

        require("telescope.pickers").new({}, opts):find()
      end

      local symbol_kind_aliases = {
        fn = "function",
        func = "function",
        var = "variable",
        meth = "method",
        iface = "interface",
        enummember = "enum_member",
      }

      local function get_valid_symbol_kinds()
        local valid = {}
        for _, kind in ipairs(vim.lsp.protocol.SymbolKind or {}) do
          if type(kind) == "string" then
            valid[kind:lower()] = true
          end
        end
        return valid
      end

      local valid_symbol_kinds = get_valid_symbol_kinds()

      local function parse_symbol_filter(raw)
        if not raw then
          return nil
        end
        local trimmed = raw:gsub("^%s+", ""):gsub("%s+$", "")
        if trimmed == "" then
          return nil
        end

        local selected, seen, invalid = {}, {}, {}
        for token in trimmed:gmatch("[^,%s]+") do
          local normalized = token:lower()
          normalized = symbol_kind_aliases[normalized] or normalized
          normalized = normalized:gsub("_", "")
          if valid_symbol_kinds[normalized] then
            if not seen[normalized] then
              seen[normalized] = true
              table.insert(selected, normalized)
            end
          else
            table.insert(invalid, token)
          end
        end

        if #selected == 0 and #invalid > 0 then
          local available = vim.tbl_keys(valid_symbol_kinds)
          table.sort(available)
          vim.notify(
            "Unknown symbol type(s): "
              .. table.concat(invalid, ", ")
              .. ". Use one of: "
              .. table.concat(available, ", "),
            vim.log.levels.WARN
          )
          return nil, false
        end

        if #invalid > 0 then
          vim.notify("Ignoring unknown symbol type(s): " .. table.concat(invalid, ", "), vim.log.levels.WARN)
        end

        return #selected > 0 and selected or nil, true
      end

      local function prompt_symbol_filter(prompt, cb)
        vim.ui.input({ prompt = prompt }, function(input)
          if input == nil then
            return
          end
          local symbols, ok = parse_symbol_filter(input)
          if ok == false then
            return
          end
          cb(symbols)
        end)
      end

      local function workspace_symbols(opts)
        opts = opts or {}
        local supports_workspace_symbols = false
        for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
          if client.supports_method("workspace/symbol") then
            supports_workspace_symbols = true
            break
          end
        end

        if not supports_workspace_symbols then
          vim.notify("No attached LSP supports workspace symbols in this buffer", vim.log.levels.WARN)
          return
        end

        if builtin.lsp_dynamic_workspace_symbols then
          builtin.lsp_dynamic_workspace_symbols(opts)
          return
        end

        vim.ui.input({ prompt = "Workspace symbol query: " }, function(input)
          if not input or input == "" then
            return
          end
          local query_opts = vim.tbl_deep_extend("force", {}, opts, { query = input })
          builtin.lsp_workspace_symbols(query_opts)
        end)
      end

      local function document_symbols_with_type_filter()
        prompt_symbol_filter("Document symbol type(s) (optional, e.g. function,method,variable): ", function(symbols)
          local opts = {}
          if symbols then
            opts.symbols = symbols
          end
          builtin.lsp_document_symbols(opts)
        end)
      end

      local function workspace_symbols_with_type_filter()
        prompt_symbol_filter("Workspace symbol type(s) (optional, e.g. function,method,variable): ", function(symbols)
          local opts = {}
          if symbols then
            opts.symbols = symbols
          end
          workspace_symbols(opts)
        end)
      end

      local function pick_theme_with_persist()
        local side_layout = telescope_themes.get_dropdown({
          previewer = false,
          winblend = 0,
          layout_strategy = "vertical",
          layout_config = {
            width = 0.45,
            height = 0.75,
            prompt_position = "top",
            preview_cutoff = 1,
          },
        })

        local function is_dark_theme(name)
          local lower = name:lower()
          return not (
            lower:match("light")
            or lower:match("latte")
            or lower:match("dawn")
            or lower:match("day")
            or lower:match("lotus")
            or lower:match("white")
            or lower:match("morning")
          )
        end

        local color_set = {}
        for _, color in ipairs(vim.fn.getcompletion("", "color")) do
          color_set[color] = true
        end
        for _, path in ipairs(vim.api.nvim_get_runtime_file("colors/*.vim", true)) do
          local color = vim.fn.fnamemodify(path, ":t:r")
          color_set[color] = true
        end
        local colors = {}
        for color in pairs(color_set) do
          if is_dark_theme(color) then
            table.insert(colors, color)
          end
        end
        table.sort(colors)

        local before_background = vim.o.background
        local before_color = vim.g.colors_name
        local need_restore = true
        local previewers = require("telescope.previewers")
        local buffer_path = vim.api.nvim_buf_get_name(0)
        local previewer = previewers.new_buffer_previewer({
          get_buffer_by_name = function()
            return buffer_path
          end,
          define_preview = function(self)
            if buffer_path ~= "" and vim.loop.fs_stat(buffer_path) then
              require("telescope.config").values.buffer_previewer_maker(
                buffer_path,
                self.state.bufnr,
                { bufname = self.state.bufname }
              )
            else
              local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
              vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
            end
          end,
        })

        local function preview_selection()
          local entry = action_state.get_selected_entry()
          if entry and entry.value then
            pcall(vim.cmd.colorscheme, entry.value)
          end
        end

        require("telescope.pickers")
          .new(vim.tbl_deep_extend("force", {}, side_layout), {
            prompt_title = "Dark colorschemes",
            finder = require("telescope.finders").new_table({
              results = colors,
              entry_maker = make_entry.gen_from_string({}),
            }),
            sorter = sorters.get_generic_fuzzy_sorter({}),
            previewer = previewer,
            on_complete = {
              preview_selection,
            },
            attach_mappings = function(prompt_bufnr)
              actions.move_selection_next:enhance({
                post = preview_selection,
              })
              actions.move_selection_previous:enhance({
                post = preview_selection,
              })
              actions.select_default:replace(function()
                local entry = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                if entry and entry.value then
                  local ok = pcall(vim.cmd.colorscheme, entry.value)
                  if ok then
                    need_restore = false
                    theme.save(entry.value)
                  end
                end
              end)
              actions.close:enhance({
                post = function()
                  if need_restore and before_color then
                    vim.o.background = before_background
                    pcall(vim.cmd.colorscheme, before_color)
                  end
                end,
              })
              return true
            end,
          })
          :find()
      end

      vim.api.nvim_create_user_command("FindFilesByExt", function(cmd_opts)
        find_files_by_extension(cmd_opts.args)
      end, {
        nargs = 1,
        desc = "Find files by extension (example: FindFilesByExt lua)",
      })

      vim.keymap.set("n", "<leader>/", live_grep_ignored, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>?", command_palette, { desc = "Command palette" })
      vim.keymap.set("n", "<leader>ff", find_files_ignored, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fF", find_files_ignored, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fE", function()
        vim.ui.input({ prompt = "Extension: " }, function(input)
          if input then
            find_files_by_extension(input)
          end
        end)
      end, { desc = "Find files by extension" })
      vim.keymap.set("n", "<leader>fg", live_grep_ignored, { desc = "Grep files" })
      vim.keymap.set("n", "<leader>fG", live_grep_ignored, { desc = "Grep files" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
      vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
      vim.keymap.set("n", "<leader>h/", help_live_grep, { desc = "Help grep" })
      vim.keymap.set("n", "<leader>hh", builtin.help_tags, { desc = "Help tags" })
      vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
      vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Document symbols" })
      vim.keymap.set("n", "<leader>fS", workspace_symbols, { desc = "Workspace symbols" })
      vim.keymap.set("n", "<leader>fk", document_symbols_with_type_filter, { desc = "Document symbols by type" })
      vim.keymap.set("n", "<leader>fK", workspace_symbols_with_type_filter, { desc = "Workspace symbols by type" })
      vim.keymap.set("n", "<leader>f.", builtin.builtin, { desc = "Pickers" })
      vim.keymap.set("n", "<leader>ft", pick_theme_with_persist, { desc = "Themes" })
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              -- even more opts
            }),
          },
        },
      })
      -- To get ui-select loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function:
      require("telescope").load_extension("ui-select")
    end,
  },
}
