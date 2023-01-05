func vis#internal#tjump#open(tag_name, winnr=0)
  call vis#window#goto(a:winnr)
  exec "tjump ".a:tag_name
endfunc

func vis#internal#tjump#open_prompt()
  let line = vis#util#prompt("Tag [Winnr]? ", '??')
  if line == ""
    return
  endif

  exec "VisTjump" line
endfunc

