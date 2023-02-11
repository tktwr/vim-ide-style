"======================================================
" terminal
"======================================================
"------------------------------------------------------
" open terminal
"------------------------------------------------------
func vis#term#open(mods)
  let h = g:vis_term_winheight

  if has('nvim')
    exec printf("%s %dnew", a:mods, h)
    term
  else
    exec printf("%s term ++rows=%d", a:mods, h)
  endif

  if winnr('$') == 1
    resize
  endif

  set winfixheight
endfunc

func vis#term#vopen(mods)
  let h = winheight(0)
  exec printf("%s vnew", a:mods)
  term ++rows=1
  wincmd p
  close
  exec "resize" h
  set winfixheight
endfunc

"------------------------------------------------------
" terminal to editor
"------------------------------------------------------
func vis#term#Tapi_Exec(bufnr, cmdline)
  exec a:cmdline
endfunc

func vis#term#Tapi_ExecEcho(bufnr, cmdline)
  let output = eval(a:cmdline)
  let lines = []
  call add(lines, output)
  call writefile(lines, expand('$VIM_IDE_PIPE'))
endfunc

