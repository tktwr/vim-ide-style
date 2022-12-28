"------------------------------------------------------
" tab
"------------------------------------------------------
func vis#tab#empty()
  let last_winnr = winnr('$')
  if last_winnr == 1 && &filetype == ""
    return 1
  endif
  return 0
endfunc

func vis#tab#close_prev()
  if vis#external#dirdiff#inside()
    call vis#external#dirdiff#quit()
    tabprev
    return
  endif

  let winnr = vis#window#VisFindFirstTerm()
  if winnr == -1
    " terminal is not found in the tab
    tabclose
    if vis#tab#empty()
      " close redundant empty tab
      tabclose
    endif
    tabprev
  endif
endfunc

