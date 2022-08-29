"======================================================
" terminal
"======================================================
"------------------------------------------------------
" open terminal
"------------------------------------------------------
func vis#term#VisTerm(...)
  if a:0 == 0
    let l:type = 0
  else
    let l:type = a:1
  endif

  if l:type == 0
    if has('nvim')
      exec "below ".g:vis#vis_term_winheight."new"
      term
    else
      exec "below term ++rows=".g:vis#vis_term_winheight
    endif
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

func vis#term#VisTermV()
  vnew
  exec "term ++rows=1"
  wincmd p
  close
  exec "resize".g:vis#vis_term_winheight
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

