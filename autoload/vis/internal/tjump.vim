func vis#internal#tjump#VisTjump(tag_name, winnr=0)
  call vis#window#VisGotoWinnr(a:winnr)
  exec "tjump ".a:tag_name
endfunc

func vis#internal#tjump#VisTjumpPrompt()
  let line = vis#util#VisPrompt("Tag [Winnr]? ", '??')
  if line == ""
    return
  endif

  exec "VisTjump" line
endfunc

