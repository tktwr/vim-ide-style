func vis#external#fugitive#VisGgrep(word)
  let word = vis#util#VisPrompt("Word? ", a:word)
  if word == ""
    return
  endif

  let cmd = printf("Ggrep -I '%s' -- ':!tags*'", word)
  exec cmd
endfunc

func vis#external#fugitive#VisGstatusToggle()
  if (&filetype == "fugitive")
    normal q
  else
    above Git
    exec "resize" g:my_gstatus_winheight
  endif
endfunc

func vis#external#fugitive#VisFugitiveMap()
  nmap <buffer> D       dd
endfunc

