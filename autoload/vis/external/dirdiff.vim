"======================================================
" dirdiff
"======================================================
func vis#external#dirdiff#open(dir1, dir2, tab=v:true)
  let dir1 = vis#util#abs_filepath(a:dir1)
  let dir2 = vis#util#abs_filepath(a:dir2)

  if !(isdirectory(dir1) && isdirectory(dir2))
    echom printf("ERROR: dirdiff: cannot open directories")
    echom printf("dir1: [%s]", dir1)
    echom printf("dir2: [%s]", dir2)
    return
  endif

  if a:tab
    tabedit
  endif

  let dir1 = substitute(dir1, ' ', '\\ ', 'g')
  let dir2 = substitute(dir2, ' ', '\\ ', 'g')
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

