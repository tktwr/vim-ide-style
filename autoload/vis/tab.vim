"------------------------------------------------------
" tab
"------------------------------------------------------
func vis#tab#VisIsEmptyTab()
  let last_winnr = winnr('$')
  if last_winnr == 1 && &filetype == ""
    return 1
  endif
  return 0
endfunc

func vis#tab#VisTabClosePrev()
  let winnr = vis#window#VisFindFirstTerm()
  if winnr == -1
    " terminal is not found in the tab
    tabclose
    if vis#tab#VisIsEmptyTab()
      " close redundant empty tab
      tabclose
    endif
    tabprev
  endif
endfunc

"------------------------------------------------------
" diff
"------------------------------------------------------
func vis#tab#VisTabDiff(file1, file2)
  exec "tabedit" a:file2
  exec "vertical diffsplit" a:file1
endfunc

"------------------------------------------------------
" dirdiff
"------------------------------------------------------
func vis#tab#VisDirDiff(dir1, dir2)
  let dir1 = substitute(a:dir1, ' ', '\\ ', 'g')
  let dir2 = substitute(a:dir2, ' ', '\\ ', 'g')

  exec "DirDiff" dir1 dir2
  redraw!
endfunc

func vis#tab#VisTabDirDiff(dir1, dir2)
  tabedit
  call vis#tab#VisDirDiff(a:dir1, a:dir2)
endfunc

func vis#tab#VisTabDirDiffQuit()
  exec "DirDiffQuit"
  tabclose
endfunc

