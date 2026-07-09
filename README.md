# Neovim config

This is a Helix-style Neovim setup with Telescope + Alpha as the main UI.

## What is enabled

- Theme: `dark-af` (default, based on vimichael/my-nvim-config)
- Theme alias names: `dark_af`, `vimichael-custom`, `custom`
- Additional custom theme: `golden_gate` (alias: `golden-gate`, based on your Helix theme)
- Tree-sitter: syntax + textobjects + motions
- LSP: Mason + `nvim-lspconfig`
- Formatting: `conform.nvim` with format-on-save
- Dashboard: `alpha-nvim`

## Main keymaps

- `<leader>/` command palette (`Telescope commands`)
- `<leader>?` keymap search
- `<leader>K` keymap groups (which-key popup)
- `<leader>:` command history
- `<leader>ff` find files
- `<leader>fF` find files (same, filtered)
- `<leader>fg` live grep
- `<leader>fG` live grep (same, filtered)
- `<leader>fE` find files by extension (prompts for ext)
- `<leader>bb` buffers
- `<leader>fr` recent files
- `<leader>hh` help tags
- `<leader>h/` help grep

## Navigation (Helix-like)

- `]d` / `[d` next/previous diagnostic
- `]s` / `[s` next/previous symbol
- `]f` / `[f` next/previous function or method
- `]t` / `[t` next/previous type or class
- `]a` / `[a` next/previous argument
- `]g` / `[g` next/previous git hunk
- `]p` / `[p` next/previous paragraph

## Editing

- `u` undo
- `U` redo
- `Ctrl-c` toggle comment
- `Ctrl-,` indent left
- `Ctrl-.` indent right
- `x` select line down (`3x` selects 3 lines)
- `X` select line up
- `m` enter visual mode (Helix-like select)
- `R` replace selection with active register
- `gh` hover docs (same as `K`)

## Terminal, tree, file manager

- `<leader>tt` floating terminal
- `<leader>th` horizontal terminal
- `<leader>tv` vertical terminal
- `<leader>e` Neo-tree toggle
- `<leader>y` Yazi in cwd (updates Neovim cwd on close)
- `<leader>yc` Yazi on buffer path
- `<leader>cp` project picker (interactive cd)

## Toggles

- `<leader>tf` autoformat
- `<leader>tb` inline blame
- `<leader>ti` indent guides
- `<leader>tr` relative numbers
- `<leader>ts` spellcheck

## Commands

- `:ConfigOpen` open `init.lua`
- `:ConfigReload` reload config
- `:OpenInObsidian` open current markdown note in Obsidian
- `:MarkdownPreviewToggle` toggle markdown render preview
- `:ToggleInlineBlame` toggle inline git blame
- `:ThemeDarkAf` force `dark-af` and save it as active theme
- `:FindFilesByExt <ext>` find files by extension (example: `lua`)

## Startup behavior

Running `nvim .` opens Telescope file search in that directory.
