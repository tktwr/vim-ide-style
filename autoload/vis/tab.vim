"------------------------------------------------------
" tab
"------------------------------------------------------
func vis#tab#TtIsEmptyTab()
  let last_winnr = winnr('$')
  if last_winnr == 1 && &filetype == ""
    return 1
  endif
  return 0
endfunc

func vis#tab#MyTabClosePrev()
  let winnr = vis#window#TtFindFirstTerm()
  if winnr == -1
    " terminal is not found in the tab
    tabclose
    if vis#tab#TtIsEmptyTab()
      " close redundant empty tab
      tabclose
    endif
    tabprev
  endif
endfunc

"------------------------------------------------------
" diff
"------------------------------------------------------
func vis#tab#MyTabDiff(file1, file2)
  exec "tabedit" a:file2
  exec "vertical diffsplit" a:file1
endfunc

"------------------------------------------------------
" dirdiff
"------------------------------------------------------
func vis#tab#MyDirDiff(dir1, dir2)
  let dir1 = substitute(a:dir1, ' ', '\\ ', 'g')
  let dir2 = substitute(a:dir2, ' ', '\\ ', 'g')

  exec "DirDiff" dir1 dir2
  redraw!
endfunc

func vis#tab#MyTabDirDiff(dir1, dir2)
  tabedit
  call vis#tab#MyDirDiff(a:dir1, a:dir2)
endfunc

func vis#tab#MyTabDirDiffQuit()
  exec "DirDiffQuit"
  tabclose
endfunc

