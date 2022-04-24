"------------------------------------------------------
" editor to terminal
"------------------------------------------------------
" send a cmd to a terminal
func vis#send#VisSendCmdE2T(cmd)
  let cmd = a:cmd
  if (cmd == "")
    let cmd = bmk#util#BmkRemoveBeginEndSpaces(getline('.'))
    let cmd = "> ".cmd."<CR>"
  endif
  wincmd j
  let winnr = winnr()
  call bmk#BmkExecTermCommand(cmd, winnr)
endfunc

" send 'cd dir' to a terminal
func vis#send#VisSendCdE2T()
  let dir = expand('%:p:h')
  wincmd j
  let winnr = winnr()
  call bmk#BmkEditDir(dir, winnr)
endfunc

"------------------------------------------------------
" terminal to terminal
"------------------------------------------------------
" send 'cd dir' to a terminal
func vis#send#VisSendCdT2T(dir, winnr)
  let dir = vis#util#VisExpandDir(a:dir)
  call bmk#BmkEditDir(dir, a:winnr)
endfunc

"------------------------------------------------------
" terminal to editor
"------------------------------------------------------
func vis#send#VisVResizeT2E(width)
  exec "vertical resize" a:width
  let w:orig_width = a:width
endfunc

