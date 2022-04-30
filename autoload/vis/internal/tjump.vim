func vis#internal#tjump#VisTjump(tag_name, winnr=0)
  call vis#window#VisGotoWinnr(a:winnr)
  exec "tjump ".a:tag_name
  "exec "lcd" expand("%:p:h")
endfunc

func vis#internal#tjump#VisTjumpPrompt()
  let line = vis#util#VisPrompt("tag winnr? ", '??')
  if line == ""
    return
  endif

  exec "VisTjump" line
endfunc

