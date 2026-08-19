# Personal Neovim

A focused daily-driver configuration: Neovim’s modal editing with a small Helix-style selection layer, a searchable action surface, and the dark Mono Glow theme.

## Requirements

- Neovim 0.11+
- `git`, `rg`, and `make`
- Formatter and LSP executables only for languages you use

## Defaults

- Relative line numbers, visible sign column, and a one-line command area
- Smart-case search
- Manual folding, disabled until explicitly used
- Inline diagnostics, indent guides, and format-on-save disabled by default
- `<C-s>` saves in normal, insert, and visual mode

## Navigation and selection

- `s`, `m`, and `%` retain the Helix-style selection layer
- `.` and `;` retain native Vim repeat behavior
- `[b` / `]b` switch buffers
- `[d` / `]d` switch diagnostics
- `[s` / `]s` switch document symbols
- `[f` / `]f`, `[t` / `]t`, `[a` / `]a`, `[l` / `]l`, `[i` / `]i` navigate Tree-sitter targets

## Search and actions

- `<leader>/` — live grep from the project root
- `<leader>ff` — files from the project root
- `<leader>fr` — recent files
- `<leader>fE` — files by extension
- `<leader>fs` / `<leader>fS` — document/workspace symbols
- `<leader>ft` — curated theme picker
- `<leader>h/` — live grep Neovim and plugin documentation
- `<leader>hh` — help tags
- `<leader>?` — curated action palette; searches mappings and meaningful custom commands
- `<leader>K` — which-key groups

## Bookmarks and jump history

- `<leader>ja` — toggle a persistent project bookmark
- `<leader>jb` — browse project bookmarks in Telescope
- `<leader>jl` — browse native Neovim jump history with path, line, and nearby text
- `<C-o>` / `<C-i>` — native jumplist back/forward

Bookmarks use `lspmark.nvim`: they are project-scoped, persistent, and searchable by comment, file, symbol, and kind.

## Code actions

- `K`, `gd`, `gD`, `gr`, `gi`, `grn`, and `gra` use standard Neovim LSP behavior
- `<leader>rf` — format the current buffer
- `<leader>dd` — buffer diagnostics picker
- `<leader>do` — diagnostics at cursor
- `<leader>dq` — diagnostics to quickfix

## UI and tools

- `<leader>bb` / `<leader>bd` — list/delete buffers
- `<leader>y` / `<leader>yc` — Yazi in cwd/current buffer path
- `<leader>cp` — switch project
- `<leader>tf`, `<leader>td`, `<leader>ti`, `<leader>tr`, `<leader>ts` — toggle format, inline diagnostics, indent guides, relative numbers, spellcheck

## Themes

The Huez-powered theme picker is intentionally limited to:

- `personal` — your default blue-black surface
- `sora` — ethereal cyan, cool silver, and deep OLED blacks
- `claude-dark` — Claude Code-inspired warm charcoal theme with orange emphasis
- `golden_gate` — opaque warm dusk theme shared with Ghostty and Helix
- `oxocarbon` — IBM Carbon-inspired dark theme
- `kanagawa-wave-reduced`, `kanagawa-dragon-reduced` — reduced-palette Kanagawa variants
- `zenwritten` — almost entirely neutral syntax coloring
- `github-monochrome-dark` — restrained monochrome dark theme
- `nightfox`, `dayfox`, `dawnfox`, `duskfox`, `nordfox`, `terafox`,
  `carbonfox` — Nightfox's complete theme family
- `nord`, `nord-darker`, `nord-night`, `nordic` — classic Nord, its darker-background variant, Helix Nord Night, and Nordic's darker, warmer variant
- `habamax`, `vim` — bundled Neovim and Vim baselines
- `monoglow-z`, `monoglow-lack`, `monoglow-void` — Mono Glow's dark styles

Open it with `<leader>ft`. Move with `j`/`k` to preview, press Enter to keep a
theme, or Escape to restore the previously saved theme.

Use `<leader>fT` for Theme Hub when you want to discover or install a new
theme. It does not replace Huez's saved selection or expand the daily picker.

`monoglow-z` is the active palette for the matching Ghostty and tmux themes.

## Commands

- `:ConfigOpen`
- `:ConfigReload` — reload core configuration; restart after plugin-spec changes
- `:ProjectFiles`, `:ProjectGrep`
- `:FindFilesByExt <extension>`
- `:FormatEnable`, `:FormatDisable`
- `:ToggleInlineDiagnostics`, `:ToggleInlineBlame`
