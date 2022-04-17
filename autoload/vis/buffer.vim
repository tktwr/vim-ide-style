"------------------------------------------------------
" buffer delete
"------------------------------------------------------
func vis#buffer#MyBufDelete()
  let nr = bufnr('%')
  enew
  exec "bdelete" nr
endfunc

"------------------------------------------------------
" buffer exchange
"------------------------------------------------------
func vis#buffer#MyWinBufExchange(winnr)
  let winnr = vis#util#MyPrompt("Winnr? ", a:winnr)
  if winnr == ""
    return
  endif

  let src_bufnr = bufnr('%')
  exec winnr."wincmd w"
  let dst_bufnr = bufnr('%')
  exec src_bufnr."b"
  wincmd p
  exec dst_bufnr."b"
endfunc

"------------------------------------------------------
" buffer copy
"------------------------------------------------------
func vis#buffer#MyWinBufCopy(winnr)
  let winnr = vis#util#MyPrompt("Winnr? ", a:winnr)
  if winnr == ""
    return
  endif

  let src_bufnr = bufnr('%')
  exec winnr."wincmd w"
  exec src_bufnr."b"
  wincmd p
endfunc

