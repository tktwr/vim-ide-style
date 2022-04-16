"======================================================
" terminal
"======================================================
"------------------------------------------------------
" open terminal
"------------------------------------------------------
func vis#term#MyTerm(...)
  if a:0 == 0
    let l:type = 0
  else
    let l:type = a:1
  endif
  if l:type == 0
    exec "below term ++rows=".g:my_term_winheight
    set winfixheight
  elseif l:type == 1
    tabedit
    bot term
    only
  elseif l:type == 2
    tabedit
    bot term
    only
    bot term
  endif
endfunc

func vis#term#MyTermV()
  vnew
  exec "term ++rows=1"
  wincmd p
  close
  exec "resize".g:my_term_winheight
  set winfixheight
endfunc

"------------------------------------------------------
" terminal to editor
"------------------------------------------------------
func vis#term#Tapi_Exec(bufnr, cmdline)
  exec a:cmdline
endfunc

func vis#term#Tapi_ExecInPrevWin(bufnr, cmdline)
  wincmd p
  exec a:cmdline
endfunc

func vis#term#Tapi_ExecInAboveWin(bufnr, cmdline)
  wincmd k
  exec a:cmdline
endfunc

func vis#term#Tapi_ExecInNewTab(bufnr, cmdline)
  tabedit
  exec a:cmdline
endfunc

