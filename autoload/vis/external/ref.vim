func vis#external#ref#open_prompt(cmd, word)
  let word = vis#util#VisPrompt("Word? ", a:word)
  if word == ""
    return
  endif

  exec "vertical resize" g:vis#vis_help_winwidth
  if &filetype =~ "ref-*"
    exec "above Ref" a:cmd word
  else
    exec "above Ref" a:cmd word
    call vis#window#close_prev_win()
  endif
endfunc

