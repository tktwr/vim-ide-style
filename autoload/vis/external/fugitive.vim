func vis#external#fugitive#ggrep(word)
  let word = vis#util#prompt("Word? ", a:word)
  if word == ""
    return
  endif

  let cmd = printf("silent Ggrep -I '%s' -- ':!tags*'", word)
  exec cmd
endfunc

func vis#external#fugitive#toggle()
  if !FugitiveIsGitDir()
    return
  endif

  if (&filetype == "fugitive")
    normal q
  else
    tabedit
    above Git
    exec "resize" g:vis_gstatus_winheight

    let label = printf('GS:%s', vis#util#git_repo_name())
    call vis#tabline#set_label(label)
  endif
endfunc

func vis#external#fugitive#map()
  nmap <buffer> D       dd
endfunc

