" golden_gate: based on ~/.config/helix/themes/golden-gate.toml
set bg=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "golden_gate"

highlight Normal        gui=NONE guifg=#c4b5aa guibg=NONE ctermbg=NONE
highlight NormalFloat   gui=NONE guifg=#c4b5aa guibg=NONE ctermbg=NONE
highlight NormalNC      gui=NONE guifg=#c4b5aa guibg=NONE ctermbg=NONE
highlight EndOfBuffer   gui=NONE guifg=#5c504a guibg=NONE ctermbg=NONE
highlight SignColumn    gui=NONE guifg=#5c504a guibg=NONE ctermbg=NONE
highlight Comment       gui=italic guifg=#5c504a
highlight TSComment     gui=italic guifg=#5c504a
highlight Conceal       gui=NONE guifg=#5c504a guibg=#121010
highlight Constant      gui=NONE guifg=#bfa073
highlight String        gui=NONE guifg=#7594a8
highlight Number        gui=NONE guifg=#bfa073
highlight Boolean       gui=NONE guifg=#bfa073
highlight Function      gui=NONE guifg=#bfae7e
highlight Identifier    gui=NONE guifg=#c4b5aa
highlight Type          gui=NONE guifg=#dbcabf
highlight Statement     gui=NONE guifg=#ba5343
highlight Operator      gui=NONE guifg=#5c504a
highlight PreProc       gui=NONE guifg=#ba5343
highlight Special       gui=NONE guifg=#7594a8
highlight SpecialChar   gui=NONE guifg=#7594a8
highlight SpecialKey    gui=NONE guifg=#5c504a

highlight LineNr        gui=NONE guifg=#5c504a
highlight LineNrAbove   gui=NONE guifg=#5c504a guibg=#121010
highlight LineNrBelow   gui=NONE guifg=#5c504a guibg=#121010
highlight NonText       gui=NONE guifg=#5c504a
highlight CursorLine    gui=NONE guibg=#221e1e
highlight CursorColumn  gui=NONE guibg=#221e1e
highlight ColorColumn   gui=NONE guibg=#221e1e

highlight Pmenu         gui=NONE guifg=#c4b5aa guibg=#121010
highlight PmenuSel      gui=NONE guifg=#121010 guibg=#bfae7e
highlight PmenuSbar     gui=NONE guibg=#221e1e
highlight PmenuThumb    gui=NONE guibg=#332b28

highlight StatusLine    gui=NONE guifg=#c4b5aa guibg=#121010
highlight StatusLineNC  gui=NONE guifg=#5c504a guibg=#121010
highlight TabLine       gui=NONE guifg=#5c504a guibg=#221e1e
highlight TabLineSel    gui=bold guifg=#121010 guibg=#bfae7e
highlight TabLineFill   gui=NONE guibg=#121010
highlight WinSeparator  gui=NONE guifg=#221e1e guibg=#121010
highlight VertSplit     gui=NONE guifg=#221e1e

highlight Visual        gui=NONE guibg=#332b28
highlight Search        gui=NONE guifg=#121010 guibg=#bfae7e
highlight IncSearch     gui=NONE guifg=#121010 guibg=#bfa073
highlight MatchParen    gui=NONE guifg=#121010 guibg=#bfa073

highlight DiffAdd       gui=NONE guibg=#1b231f
highlight DiffChange    gui=NONE guibg=#221e1e
highlight DiffDelete    gui=NONE guibg=#2a1b1b
highlight DiffText      gui=NONE guibg=#332b28

highlight Directory     gui=NONE guifg=#7594a8
highlight Error         gui=undercurl guifg=#ba5343
highlight ErrorMsg      gui=NONE guifg=#ba5343
highlight WarningMsg    gui=NONE guifg=#bfa073
highlight Question      gui=NONE guifg=#7594a8
highlight Todo          gui=NONE guifg=#121010 guibg=#bfae7e
highlight Underlined    gui=underline
highlight Title         gui=NONE guifg=#dbcabf
highlight Float         gui=NONE guifg=#c4b5aa

highlight @markup.link.label.markdown_inline gui=NONE
