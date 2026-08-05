" Golden Gate: an opaque, warm dusk theme shared with Ghostty and Helix.
set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "golden_gate"

highlight Normal             guifg=#d8c7bb guibg=NONE ctermbg=NONE cterm=NONE gui=NONE
highlight NormalNC           guifg=#d8c7bb guibg=NONE ctermbg=NONE cterm=NONE gui=NONE
highlight NormalFloat        guifg=#d8c7bb guibg=#201a19 cterm=NONE gui=NONE
highlight FloatBorder        guifg=#4a3d37 guibg=#201a19 cterm=NONE gui=NONE
highlight SignColumn         guifg=#75665f guibg=NONE ctermbg=NONE cterm=NONE gui=NONE
highlight EndOfBuffer        guifg=#75665f guibg=NONE ctermbg=NONE cterm=NONE gui=NONE
highlight WinSeparator       guifg=#4a3d37 guibg=NONE ctermbg=NONE cterm=NONE gui=NONE
highlight LineNr             guifg=#99877d guibg=NONE ctermbg=NONE cterm=NONE gui=NONE
highlight LineNrAbove        guifg=#75665f guibg=NONE ctermbg=NONE cterm=NONE gui=NONE
highlight LineNrBelow        guifg=#75665f guibg=NONE ctermbg=NONE cterm=NONE gui=NONE
highlight CursorLine         guibg=#2b2320 cterm=NONE gui=NONE
highlight CursorLineNr       guifg=#e0c087 guibg=#2b2320 cterm=NONE gui=bold
highlight Visual             guibg=#3a2d27 cterm=NONE gui=NONE
highlight Search             guifg=#171313 guibg=#e0c087 cterm=NONE gui=NONE
highlight IncSearch          guifg=#171313 guibg=#83a6b7 cterm=NONE gui=NONE
highlight MatchParen         guifg=#e0c087 guibg=#2b2320 cterm=NONE gui=bold

highlight Pmenu              guifg=#d8c7bb guibg=#201a19 cterm=NONE gui=NONE
highlight PmenuSel           guifg=#d8c7bb guibg=#3a2d27 cterm=NONE gui=bold
highlight PmenuSbar          guibg=#201a19 cterm=NONE gui=NONE
highlight PmenuThumb         guibg=#99877d cterm=NONE gui=NONE
highlight StatusLine         guifg=#d8c7bb guibg=#201a19 cterm=NONE gui=NONE
highlight StatusLineNC       guifg=#99877d guibg=#201a19 cterm=NONE gui=NONE
highlight TabLine            guifg=#99877d guibg=#201a19 cterm=NONE gui=NONE
highlight TabLineSel         guifg=#d8c7bb guibg=#2b2320 cterm=NONE gui=bold
highlight TabLineFill        guibg=#201a19 cterm=NONE gui=NONE

highlight Comment            guifg=#75665f cterm=NONE gui=italic
highlight TSComment          guifg=#75665f cterm=NONE gui=italic
highlight Constant           guifg=#d3ad76 cterm=NONE gui=NONE
highlight String             guifg=#83a6b7 cterm=NONE gui=NONE
highlight Character          guifg=#83a6b7 cterm=NONE gui=NONE
highlight Number             guifg=#d3ad76 cterm=NONE gui=NONE
highlight Boolean            guifg=#d3ad76 cterm=NONE gui=NONE
highlight Identifier         guifg=#d8c7bb cterm=NONE gui=NONE
highlight Function           guifg=#e0c087 cterm=NONE gui=NONE
highlight Statement          guifg=#c96b59 cterm=NONE gui=bold
highlight Keyword            guifg=#c96b59 cterm=NONE gui=bold
highlight Type               guifg=#e0c087 cterm=NONE gui=NONE
highlight PreProc            guifg=#b28b81 cterm=NONE gui=NONE
highlight Operator           guifg=#99877d cterm=NONE gui=NONE
highlight Delimiter          guifg=#99877d cterm=NONE gui=NONE
highlight Special            guifg=#83a6b7 cterm=NONE gui=NONE

highlight DiagnosticError            guifg=#c96b59 cterm=NONE gui=NONE
highlight DiagnosticWarn             guifg=#d3ad76 cterm=NONE gui=NONE
highlight DiagnosticInfo             guifg=#83a6b7 cterm=NONE gui=NONE
highlight DiagnosticHint             guifg=#8ca996 cterm=NONE gui=NONE
highlight DiagnosticVirtualTextError guifg=#c96b59 guibg=#201a19 cterm=NONE gui=NONE
highlight DiagnosticVirtualTextWarn  guifg=#d3ad76 guibg=#201a19 cterm=NONE gui=NONE
highlight DiagnosticVirtualTextInfo  guifg=#83a6b7 guibg=#201a19 cterm=NONE gui=NONE
highlight DiagnosticVirtualTextHint  guifg=#8ca996 guibg=#201a19 cterm=NONE gui=NONE

highlight lualine_a_normal guifg=#171313 guibg=#e0c087 cterm=NONE gui=bold
highlight lualine_b_normal guifg=#d8c7bb guibg=#2b2320 cterm=NONE gui=NONE
highlight lualine_c_normal guifg=#d8c7bb guibg=#201a19 cterm=NONE gui=NONE
highlight lualine_x_normal guifg=#99877d guibg=#201a19 cterm=NONE gui=NONE
highlight lualine_y_normal guifg=#d8c7bb guibg=#2b2320 cterm=NONE gui=NONE
highlight lualine_z_normal guifg=#171313 guibg=#83a6b7 cterm=NONE gui=bold
highlight lualine_c_inactive guifg=#75665f guibg=#201a19 cterm=NONE gui=NONE

highlight BufferLineFill              guibg=#201a19 cterm=NONE gui=NONE
highlight BufferLineBackground        guifg=#99877d guibg=#201a19 cterm=NONE gui=NONE
highlight BufferLineBufferSelected    guifg=#d8c7bb guibg=#2b2320 cterm=NONE gui=bold
highlight BufferLineSeparator         guifg=#201a19 guibg=#201a19 cterm=NONE gui=NONE
highlight BufferLineSeparatorSelected guifg=#201a19 guibg=#2b2320 cterm=NONE gui=NONE
highlight BufferLineIndicatorSelected guifg=#e0c087 guibg=#2b2320 cterm=NONE gui=NONE
