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
  if vis#external#dirdiff#VisTabInDirDiff()
    call vis#external#dirdiff#VisTabDirDiffQuit()
    tabprev
    return
  endif

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

