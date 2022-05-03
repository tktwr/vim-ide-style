"======================================================
" highlight
"======================================================

func vis#highlight#VisHighlight()
  hi VisRed                   ctermfg=167 guifg=#fb4934
  hi VisGreen                 ctermfg=142 guifg=#b8bb26
  hi VisYellow                ctermfg=214 guifg=#fabd2f
  hi VisBlue                  ctermfg=109 guifg=#707fd9
  hi VisPurple                ctermfg=175 guifg=#d3869b
  hi VisAqua                  ctermfg=108 guifg=#8ec07c
  hi VisOrange                ctermfg=208 guifg=#fe8019

  let g:terminal_ansi_colors = [
  \ '#000000',
  \ '#fb4934',
  \ '#b8bb26',
  \ '#fabd2f',
  \ '#707fd9',
  \ '#d3869b',
  \ '#8ec07c',
  \ '#fe8019',
  \ '#000000',
  \ '#fb4934',
  \ '#b8bb26',
  \ '#fabd2f',
  \ '#707fd9',
  \ '#d3869b',
  \ '#8ec07c',
  \ '#fe8019',
  \ ]
endfunc
