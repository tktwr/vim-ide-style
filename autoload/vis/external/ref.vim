func vis#external#ref#MyRef(cmd, word)
  let word = vis#util#MyPrompt("Word? ", a:word)
  if word == ""
    return
  endif

  exec "vertical resize" g:my_help_winwidth
  if &filetype =~ "ref-*"
    exec "above Ref" a:cmd word
  else
    exec "above Ref" a:cmd word
    call vis#window#MyClosePrevWin()
  endif
endfunc

