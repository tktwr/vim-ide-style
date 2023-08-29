"------------------------------------------------------
" buffer lcd_here
"------------------------------------------------------
func vis#buffer#lcd_here()
  let file = expand('%:p')
  if filereadable(file)
    exec "lcd" fnamemodify(file, ':h')
  endif
endfunc

func vis#buffer#lcd_git_root()
  call vis#buffer#lcd_here()
  if FugitiveIsGitDir()
    exec "lcd" vis#util#git_root_dir()
  endif
endfunc

func vis#buffer#modifiable()
  set modifiable
  set noreadonly
endfunc

"------------------------------------------------------
" buffer delete
"------------------------------------------------------
func vis#buffer#delete()
  let nr = bufnr('%')
  enew
  exec "bdelete" nr
endfunc

"------------------------------------------------------
" buffer exchange
"------------------------------------------------------
func vis#buffer#exchange(winnr)
  let winnr = vis#util#prompt("Winnr? ", a:winnr)
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
func vis#buffer#copy(winnr)
  let winnr = vis#util#prompt("Winnr? ", a:winnr)
  if winnr == ""
    return
  endif

  let src_bufnr = bufnr('%')
  exec winnr."wincmd w"
  exec src_bufnr."b"
  wincmd p
endfunc

