func vis#internal#tjump#MyTjump(tag_name, winnr=0)
  call vis#window#TtGotoWinnr(a:winnr)
  exec "tjump ".a:tag_name
endfunc

func vis#internal#tjump#MyTjumpPrompt()
  let line = vis#util#MyPrompt("tag winnr? ", '??')
  if line == ""
    return
  endif

  exec "MyTjump" line
endfunc

