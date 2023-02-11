"------------------------------------------------------
" editor to terminal
"------------------------------------------------------
" send 'cd dir' to a terminal
func vis#send#cd_e2t()
  let dir = expand('%:p:h')
  wincmd j
  let winnr = winnr()
  call bmk#EditDir(dir, winnr)
endfunc

" send a cmd to a terminal
func vis#send#cmd_e2t(cmd='')
  let cmd = a:cmd
  if (cmd == '')
    let cmd = bmk#util#RemoveBeginEndSpaces(getline('.'))
    let cmd = "> ".cmd."<CR>"
  endif
  wincmd j
  let winnr = winnr()
  call bmk#ExecTermCommand(cmd, winnr)
endfunc

