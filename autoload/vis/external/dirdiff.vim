"======================================================
" dirdiff
"======================================================
func vis#external#dirdiff#open(dir1, dir2)
  let dir1 = substitute(a:dir1, ' ', '\\ ', 'g')
  let dir2 = substitute(a:dir2, ' ', '\\ ', 'g')

  exec "DirDiff" dir1 dir2
  redraw!
endfunc

func vis#external#dirdiff#quit()
  exec "DirDiffQuit"
  tabclose
endfunc

func vis#external#dirdiff#inside()
  let winnr = vis#window#VisFindFirstWindow({i, curr_winnr -> &filetype == 'dirdiff'})
  return winnr > 0
endfunc

