"======================================================
" gv
"======================================================
func vis#external#gv#map()
  nmap <buffer> D       O
endfunc

"------------------------------------------------------
func vis#external#gv#open()
  if !FugitiveIsGitDir()
    return
  endif

  GV --all

  let label = printf('GV:%s', vis#util#git_repo_name())
  call vis#tabline#set_label(label)
endfunc

