"======================================================
" highlight
"======================================================

func vis#highlight#setup()
  hi VisRed           ctermfg=167 guifg=#fb4934
  hi VisGreen         ctermfg=142 guifg=#b8bb26
  hi VisYellow        ctermfg=214 guifg=#fabd2f
  hi VisBlue          ctermfg=109 guifg=#707fd9
  hi VisPurple        ctermfg=175 guifg=#d3869b
  hi VisAqua          ctermfg=108 guifg=#8ec07c
  hi VisOrange        ctermfg=208 guifg=#fe8019

  hi VisRedRevBold    ctermfg=167 guifg=#fb4934 cterm=reverse,bold gui=reverse,bold
  hi VisGreenRevBold  ctermfg=142 guifg=#b8bb26 cterm=reverse,bold gui=reverse,bold
  hi VisYellowRevBold ctermfg=214 guifg=#fabd2f cterm=reverse,bold gui=reverse,bold
  hi VisBlueRevBold   ctermfg=109 guifg=#707fd9 cterm=reverse,bold gui=reverse,bold
  hi VisPurpleRevBold ctermfg=175 guifg=#d3869b cterm=reverse,bold gui=reverse,bold
  hi VisAquaRevBold   ctermfg=108 guifg=#8ec07c cterm=reverse,bold gui=reverse,bold
  hi VisOrangeRevBold ctermfg=208 guifg=#fe8019 cterm=reverse,bold gui=reverse,bold

  hi link VisWinNrRevBold  VisGreenRevBold
  hi link VisWinNr         VisGreen
  hi link VisFname         VisGreenRevBold
  hi link VisFname2        VisOrangeRevBold
  hi link VisGitStatus     TabLine
  hi link VisCWD           TabLine
  hi link VisInfo          TabLine

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
