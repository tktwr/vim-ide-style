func vis#internal#help#VisHelp(...)
  if &filetype == "help"
    let start_from_help_win=1
  else
    let start_from_help_win=0
  endif

  exec "vertical resize" g:vis#vis_help_winwidth
  if a:0 == 0
    exec "above help"
  else
    exec "above help" a:1
  endif

  if !start_from_help_win
    call vis#window#VisClosePrevWin()
  endif
endfunc

