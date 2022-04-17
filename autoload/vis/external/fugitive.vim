func vis#external#fugitive#MyGgrep(word)
  let word = vis#util#MyPrompt("Word? ", a:word)
  if word == ""
    return
  endif

  let cmd = printf("Ggrep -I '%s' -- ':!tags*'", word)
  exec cmd
endfunc

func vis#external#fugitive#MyGstatusToggle()
  if (&filetype == "fugitive")
    normal q
  else
    above Git
    exec "resize" g:my_gstatus_winheight
  endif
endfunc

func vis#external#fugitive#MyFugitiveMap()
  nmap <buffer> D       dd
endfunc

