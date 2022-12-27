"======================================================
" terminal
"======================================================
"------------------------------------------------------
" open terminal
"------------------------------------------------------
func vis#term#VisTerm(loc="below")
  if has('nvim')
    exec printf("%s %dnew", a:loc, g:vis#vis_term_winheight)
    term
  else
    exec printf("%s term ++rows=%d", a:loc, g:vis#vis_term_winheight)
  endif
  set winfixheight
endfunc

func vis#term#VisTermV()
  let h = winheight(0)
  vnew
  exec "term ++rows=1"
  wincmd p
  close
  exec "resize" h
  set winfixheight
endfunc

"------------------------------------------------------
" terminal to editor
"------------------------------------------------------
func vis#term#Tapi_ExecEcho(bufnr, cmdline)
  let output = eval(a:cmdline)
  let lines = []
  call add(lines, output)
  call writefile(lines, expand('$VIM_IDE_PIPE'))
endfunc

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

