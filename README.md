# Neovim config (Helix-style)

This config is a simplified, action-first setup with:

- Telescope for search and command picking
- Alpha for dashboard/start screen
- which-key for discoverable mappings
- Tree-sitter + LSP + Conform for coding flow
- Harpoon 2 for fast jump slots

## Design goals

1. Keep the config small and predictable.
2. Keep keymaps consistent and easy to remember.
3. Keep UI style aligned (rounded borders, plain labels, low visual noise).
4. Keep defaults safe for day-to-day coding.

## Requirements

- Neovim `0.8+`
- `git`
- `ripgrep` (`rg`) for Telescope file/grep flows
- `make` for `telescope-fzf-native.nvim`
- Optional tools used by formatters/LSP servers you enable

## Startup behavior

- `nvim` (no file args): opens Alpha dashboard
- `nvim .`: changes cwd to that directory and opens Telescope file picker
- Saved/default theme is enforced on startup (`dark_af`)

## Main UI modules

## Alpha dashboard

- Sections: `WORK`, `GIT`, `TOOLS`
- Context row: cwd + git branch
- Recents block: top 5 oldfiles
- Footer: `startup: <ms> | plugins: <count>`
- Header art: Penrose-style ASCII block

Dashboard actions:

- `[f]` files
- `[g]` grep
- `[p]` projects
- `[r]` recents
- `[s]` git status
- `[b]` git branches
- `[y]` yazi
- `[l]` lazy
- `[j]` marks (Harpoon Telescope list with preview)
- `[q]` quit

## Telescope

- Rounded borders and plain prompt labels
- FZF native enabled
- Common heavy folders ignored in find/grep (`node_modules`, `.venv`, `dist`, `build`, `target`, etc.)
- `FindFilesByExt <ext>` custom command
- Theme picker persists selected colorscheme

## which-key

- Helix preset
- Rounded popup
- Group labels are plain lowercase (`find`, `jump`, `git`, `toggle`, ...)
- Register popup is compact and includes `_`, `+`, `*` registers

## Jump flow (Harpoon 2)

- Branch: `harpoon2`
- Per-project key scope based on cwd (`settings.key = vim.loop.cwd()`)
- Keymaps:
  - `<leader>js` add current file to jump list
  - `<leader>jj` open jump list menu (Telescope preview)
  - `<leader>jJ` open Harpoon quick menu
  - `<leader>j1..4` jump to slot 1..4
  - `<leader>jn` next jump
  - `<leader>jp` previous jump
- User command: `:HarpoonQuickMenu` (Telescope preview list)

## Core plugins

- UI: `alpha-nvim`, `telescope.nvim`, `which-key.nvim`, `lualine.nvim`, `bufferline.nvim`
- Navigation: `harpoon` (harpoon2), `project.nvim`, `neo-tree.nvim`, `yazi.nvim`, `toggleterm.nvim`
- Multi-cursor: `vim-visual-multi`
- Code: `nvim-treesitter`, `nvim-lspconfig`, `mason.nvim`, `mason-lspconfig.nvim`, `blink.cmp`, `LuaSnip`
- Editing: `conform.nvim`, `Comment.nvim`, `gitsigns.nvim`, `indent-blankline.nvim`
- Markdown: `render-markdown.nvim`
- Theme base: `koda.nvim` + local colors in `colors/`

## Options and behavior

From `lua/options.lua`:

- Relative numbers enabled by default
- `scrolloff = 10`
- `signcolumn = "no"`
- Splits open right
- Tree-sitter folding (`foldexpr`)
- 2-space indent defaults
- Case-insensitive search (`ignorecase`)
- shell:
  - windows: `powershell`
  - linux/mac: `/bin/zsh`

## Language support

Mason installs and LSP config enables:

- `bashls`, `clangd`, `cssls`, `gopls`, `html`, `jsonls`, `lua_ls`
- `marksman`, `pyright`, `rust_analyzer`, `sqlls`, `ts_ls`, `yamlls`
- plus `emmet_ls` for frontend filetypes

Tree-sitter installs:

- `bash`, `c`, `css`, `go`, `html`, `javascript`, `json`, `lua`
- `markdown`, `python`, `rust`, `sql`, `tsx`, `typescript`
- `vim`, `vimdoc`, `yaml`

## Formatting

Format engine: `conform.nvim`

- `<leader>rf`: format current buffer
- format-on-save is enabled unless disabled
- toggle with:
  - `<leader>tf`
  - `:FormatDisable`
  - `:FormatEnable`

Configured formatter examples:

- Lua: `stylua`
- Python: `black`
- JS/TS/CSS/HTML/JSON/Markdown: `prettier`
- Go: `gofumpt`, `golines`, `goimports-reviser`
- Rust: `rustfmt`
- C/C++: `clang_format`

## Keymaps reference

Leader is `<Space>`.

### Search and help

- `<leader>/` live grep
- `<leader>?` command palette
- `<leader>K` key groups
- `<leader>:` command history
- `<leader>ff` / `<leader>fF` find files
- `<leader>fg` / `<leader>fG` grep files
- `<leader>fE` find files by extension
- `<leader>fb` buffers
- `<leader>fr` recent files
- `<leader>fd` diagnostics picker
- `<leader>fs` document symbols picker
- `<leader>fS` workspace symbols picker
- `<leader>fk` document symbols picker (type filter)
- `<leader>fK` workspace symbols picker (type filter)
- `<leader>f.` picker list
- `<leader>ft` theme picker
- `<leader>hh` help tags
- `<leader>h/` help grep

Type-filter prompt accepts comma-separated kinds, e.g. `function,method,variable` (`var` also works).

### Helix-style next/previous targets

- diagnostics: `]d` / `[d`
- symbols: `]s` / `[s`
- functions/methods: `]f` / `[f`
- types/classes: `]t` / `[t`
- params: `]a` / `[a`
- param ends: `]A` / `[A`
- loops: `]l` / `[l`
- conditionals: `]i` / `[i`
- git hunks: `]g` / `[g`
- paragraphs: `]p` / `[p`

### Editing and selection

- `u` undo, `U` redo
- `<C-s>` save current position to jumplist
- `<leader>jm` save current position to jumplist (fallback if terminal eats `<C-s>`)
- `<C-o>` / `<C-i>` jump back/forward in jumplist
- `%` select whole buffer
- `s` Helix-style symbol/syntax selection
- `;` collapse/remove current selection
- `m` enter visual select mode
- `v` / `V` select lines down/up; repeat to extend
- `x` / `X` delete character under/before cursor
- `R` replace selection with active register
- `<C-c>` toggle comment (normal/visual)
- `S-<` indent left, `S->` indent right (literal `<` / `>` keys)
- visual move lines: `J`, `K`, `<A-j>`, `<A-k>`
- `<C-n>` add next occurrence as multi-cursor selection

### LSP

- `K` / `gh` hover
- `gd` definition (Telescope + jumplist)
- `gD` declaration (Telescope + jumplist)
- `gO` document symbols
- `gr`, `grr` references (Telescope + jumplist)
- `gi`, `gri` implementations (Telescope + jumplist)
- `grn` rename
- `gra` code actions
- `<leader>ra` code action
- `<leader>rr` rename symbol
- `<leader>rf` format buffer
- `<leader>dh` hover docs under cursor

### Buffers and windows

- buffers: `<leader>bb`, `<leader>bd`, `<leader>bn`, `<leader>bp`, `gn`, `gp`
- window movement: `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>`
- splits: `<leader>wv`, `<leader>wh`
- close window(s): `<leader>wc`, `<leader>wo`
- resize: `=`, `-`, `+`, `^`

### Terminal, tree, yazi, project

- terminal: `<leader>tt`, `<leader>th`, `<A-i>`
- tree: `<leader>e`, `<leader>fe`
- yazi: `<leader>y`/`<leader>fy` toggle in cwd, `<leader>yc` open at buffer path
- projects: `<leader>cp`

### Toggles

- `<leader>tf` autoformat
- `<leader>tb` inline git blame
- `<leader>td` inline diagnostics
- `<leader>ti` indent guides
- `<leader>tr` relative numbers
- `<leader>ts` spellcheck

### Diagnostics

- `<leader>de` line diagnostics
- `<leader>dc` cursor diagnostics
- `<leader>dq` diagnostics to quickfix

## User commands

- `:ConfigOpen`
- `:ConfigReload`
- `:Setwd`
- `:CursorDiagnostics`
- `:HoverDoc`
- `:FindFilesByExt <ext>`
- `:MarkdownPreviewToggle`
- `:MarkdownPreview`
- `:MarkdownPreviewStop`
- `:ToggleInlineBlame`
- `:ToggleInlineDiagnostics`
- `:ThemeDarkAf`
- `:FormatDisable`
- `:FormatEnable`
- `:HarpoonQuickMenu` (Harpoon Telescope list with preview)

## Themes

Theme files in `colors/`:

- `dark_af.vim` (default)
- `golden_gate.vim`
- alias: `golden-gate.vim` -> `golden_gate.vim`
- alias: `custom.vim` -> `dark_af.vim`
- alias: `vimichael-custom.vim` -> `dark_af.vim`

Installed theme plugins:

- `lackluster`
- `koda`
- `kanagawa`
- `catppuccin`
- `rose-pine`
- `zenbones`
- `embark`
- `oxocarbon`
- `monokai-pro`
- `monokai-quiet` (custom muted green variant)
- `doom-one`
- `doom-one-darker` (custom wrapper)
- `oxocarbon-muted` (custom wrapper)

Theme persistence:

- theme selection is saved by `utils.theme`
- startup applies saved theme or `dark_af`

## Common maintenance

- open plugin manager: `<leader>ml` (`:Lazy`)
- sync plugins: `<leader>ms` (`:Lazy sync`)
- open Mason: `<leader>mm` (`:Mason`)
- update Mason registry: `<leader>mu` (`:MasonUpdate`)

## Config layout

- entrypoint: `init.lua`
- options: `lua/options.lua`
- keymaps: `lua/keymaps.lua`
- plugin specs: `lua/plugins/*.lua`
- theme helpers: `lua/utils/theme.lua`, `lua/utils/color_overrides.lua`
- colorschemes: `colors/*.vim`
