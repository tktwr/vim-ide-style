func vis#external#fugitive#ggrep(word)
  let word = vis#util#prompt("Word? ", a:word)
  if word == ""
    return
  endif

  let cmd = printf("silent Ggrep -I '%s' -- ':!tags*'", word)
  exec cmd
endfunc

func vis#external#fugitive#toggle()
  if (&filetype == "fugitive")
    normal q
  else
    above Git
    exec "resize" g:vis_gstatus_winheight
  endif
endfunc

func vis#external#fugitive#map()
  nmap <buffer> D       dd
endfunc

