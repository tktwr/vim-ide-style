"------------------------------------------------------
" editor to terminal
"------------------------------------------------------
" send a cmd to a terminal
func vis#send#MyIDESendCmdE2T(cmd)
  let cmd = a:cmd
  if (cmd == "")
    let cmd = util#TtRemoveBeginEndSpaces(getline('.'))
  endif
  wincmd j
  let bufnr = winbufnr(0)
	call term_sendkeys(bufnr, cmd."\<CR>")
endfunc

" send 'cd dir' to a terminal
func vis#send#MyIDESendCdE2T()
  let dir = expand('%:p:h')
  wincmd j
  let winnr = winnr()
  call bmk#BmkEditDir(dir, winnr)
endfunc

"------------------------------------------------------
" terminal to terminal
"------------------------------------------------------
" send 'cd dir' to a terminal
func vis#send#MyIDESendCdT2T(dir, winnr)
  let dir = vis#util#MyExpandDir(a:dir)
  call bmk#BmkEditDir(dir, a:winnr)
endfunc

"------------------------------------------------------
" terminal to editor
"------------------------------------------------------
func vis#send#MyIDEVResizeT2E(width)
  exec "vertical resize" a:width
  let w:orig_width = a:width
endfunc

