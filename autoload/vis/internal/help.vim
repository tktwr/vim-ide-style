func vis#internal#help#VisHelp(...)
  if &filetype == "help"
    let start_from_help_win=1
  else
    let start_from_help_win=0
  endif

  if winwidth(0) < g:vis#vis_help_winwidth
    exec "vertical resize" g:vis#vis_help_winwidth
  endif

  if a:0 == 0
    exec "above help"
  else
    exec "above help" a:1
  endif

  if !start_from_help_win
    call vis#window#close_prev_win()
  endif
endfunc

