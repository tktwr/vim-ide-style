"------------------------------------------------------
" buffer delete
"------------------------------------------------------
func vis#buffer#VisBufDelete()
  let nr = bufnr('%')
  enew
  exec "bdelete" nr
endfunc

"------------------------------------------------------
" buffer exchange
"------------------------------------------------------
func vis#buffer#VisWinBufExchange(winnr)
  let winnr = vis#util#VisPrompt("Winnr? ", a:winnr)
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
func vis#buffer#VisWinBufCopy(winnr)
  let winnr = vis#util#VisPrompt("Winnr? ", a:winnr)
  if winnr == ""
    return
  endif

  let src_bufnr = bufnr('%')
  exec winnr."wincmd w"
  exec src_bufnr."b"
  wincmd p
endfunc

