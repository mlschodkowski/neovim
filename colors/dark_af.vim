" dark_af: near-black, low-contrast monochrome theme.
set bg=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "dark_af"

highlight Normal        gui=NONE guifg=#C8CDD3 guibg=#0D0E10
highlight NormalFloat   gui=NONE guifg=#C8CDD3 guibg=#111317
highlight Comment       gui=NONE guifg=#70757C
highlight TSComment     gui=NONE guifg=#70757C
highlight Conceal       gui=NONE guifg=#70757C guibg=#111317
highlight Constant      gui=NONE guifg=#BCC1C8
highlight String        gui=NONE guifg=#B5BBC2
highlight Number        gui=NONE guifg=#A9B0B8
highlight Boolean       gui=NONE guifg=#A9B0B8
highlight Function      gui=NONE guifg=#C0C6CD
highlight Identifier    gui=NONE guifg=#C4CAD1
highlight Type          gui=NONE guifg=#B9BEC6
highlight Statement     gui=NONE guifg=#C2C8D0
highlight Operator      gui=NONE guifg=#9BA2AA
highlight PreProc       gui=NONE guifg=#AEB4BC
highlight Special       gui=NONE guifg=#B6BBC2
highlight SpecialChar   gui=NONE guifg=#B6BBC2
highlight SpecialKey    gui=NONE guifg=#646A72

highlight LineNr        gui=NONE guifg=#80868E
highlight LineNrAbove   gui=NONE guifg=#646A72 guibg=#0A0B0D
highlight LineNrBelow   gui=NONE guifg=#646A72 guibg=#0A0B0D
highlight NonText       gui=NONE guifg=#565C64
highlight CursorLine    gui=NONE guibg=#15181C
highlight CursorColumn  gui=NONE guibg=#15181C
highlight ColorColumn   gui=NONE guibg=#15181C

highlight Pmenu         gui=NONE guifg=#BDC3CA guibg=#16191D
highlight PmenuSel      gui=NONE guifg=#DEE2E6 guibg=#242A31
highlight PmenuSbar     gui=NONE guibg=#111317
highlight PmenuThumb    gui=NONE guibg=#343A43

highlight StatusLine    gui=NONE guifg=#CCD1D7 guibg=#1D2229
highlight StatusLineNC  gui=NONE guifg=#7E848C guibg=#12161B
highlight TabLine       gui=NONE guifg=#979DA5 guibg=#12161B
highlight TabLineSel    gui=NONE guifg=#D5DAE0 guibg=#20252D
highlight TabLineFill   gui=NONE guibg=#12161B
highlight WinSeparator  gui=NONE guifg=#424953 guibg=#0A0B0D
highlight VertSplit     gui=NONE guifg=#424953

highlight Visual        gui=NONE guibg=#262B32
highlight Search        gui=NONE guifg=#D4D9DE guibg=#313740
highlight IncSearch     gui=NONE guifg=#EAEEF2 guibg=#3D444F
highlight MatchParen    gui=NONE guifg=#EAEEF2 guibg=#2C333D

highlight DiffAdd       gui=NONE guibg=#1A221D
highlight DiffChange    gui=NONE guibg=#1C2129
highlight DiffDelete    gui=NONE guibg=#261B1F
highlight DiffText      gui=NONE guibg=#272E38

highlight Directory     gui=NONE guifg=#B4BBC3
highlight Error         gui=undercurl guifg=#C9A2A8
highlight ErrorMsg      gui=NONE guifg=#D6B3B8
highlight WarningMsg    gui=NONE guifg=#C8BCAB
highlight Question      gui=NONE guifg=#AEB5BC
highlight Todo          gui=NONE guifg=#C0C6CD guibg=#20252D
highlight Underlined    gui=underline
highlight Title         gui=NONE guifg=#CDD2D8
highlight Float         gui=NONE guifg=#B0B6BE

highlight @markup.link.label.markdown_inline gui=NONE
