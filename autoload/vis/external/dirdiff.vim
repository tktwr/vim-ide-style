"======================================================
" dirdiff
"======================================================
func vis#external#dirdiff#VisDirDiff(dir1, dir2)
  let dir1 = substitute(a:dir1, ' ', '\\ ', 'g')
  let dir2 = substitute(a:dir2, ' ', '\\ ', 'g')

  exec "DirDiff" dir1 dir2
  redraw!
endfunc

func vis#external#dirdiff#VisTabDirDiff(dir1, dir2)
  tabedit
  call vis#external#dirdiff#VisDirDiff(a:dir1, a:dir2)
endfunc

func vis#external#dirdiff#VisTabDirDiffQuit()
  exec "DirDiffQuit"
  tabclose
endfunc

