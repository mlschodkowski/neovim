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
              ["<C-r>"] = function()
                require("which-key").show({
                  keys = "<C-r>",
                  mode = "i",
                })
              end,
            },
            n = {
              ["<Esc>"] = actions.close,
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

      local function find_files_ignored()
        local find_command = { "rg", "--files", "--hidden" }
        for _, glob in ipairs(common_ignore_globs) do
          table.insert(find_command, "--glob")
          table.insert(find_command, glob)
        end
        builtin.find_files({
          hidden = true,
          find_command = find_command,
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
        })
      end

      local function live_grep_ignored()
        builtin.live_grep({
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

      local function pick_theme_with_persist()
        local side_layout = telescope_themes.get_dropdown({
          previewer = true,
          winblend = 0,
          layout_strategy = "vertical",
          layout_config = {
            width = 0.45,
            height = 0.75,
            prompt_position = "top",
            preview_cutoff = 1,
          },
        })

        builtin.colorscheme(vim.tbl_deep_extend("force", side_layout, {
          enable_preview = true,
          attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
              local entry = action_state.get_selected_entry()
              actions.close(prompt_bufnr)
              if entry and entry.value then
                local ok = pcall(vim.cmd.colorscheme, entry.value)
                if ok then
                  theme.save(entry.value)
                end
              end
            end)
            return true
          end,
        }))
      end

      vim.api.nvim_create_user_command("FindFilesByExt", function(cmd_opts)
        find_files_by_extension(cmd_opts.args)
      end, {
        nargs = 1,
        desc = "Find files by extension (example: FindFilesByExt lua)",
      })

      vim.keymap.set("n", "<leader>/", builtin.commands, { desc = "Command palette" })
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
      vim.keymap.set("n", "<leader>fS", builtin.lsp_workspace_symbols, { desc = "Workspace symbols" })
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
