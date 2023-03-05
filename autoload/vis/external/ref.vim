func vis#external#ref#open_prompt(cmd, word)
  let word = vis#util#prompt("Word? ", a:word)
  if word == ""
    return
  endif

  if winwidth(0) < g:vis_help_winwidth
    exec "vertical resize" g:vis_help_winwidth
  endif

  if &filetype =~ "ref-*"
    exec "above Ref" a:cmd word
  else
    exec "above Ref" a:cmd word
    call vis#window#close_prev_win()
  endif
endfunc

