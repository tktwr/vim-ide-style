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
func vis#buffer#exchange(dst_winnr)
  redraw
  let dst_winnr = vis#util#prompt("Winnr? ", a:dst_winnr)
  if dst_winnr == "" || dst_winnr == winnr()
    return
  endif

  let src_bufnr = bufnr('%')
  let src_lcd = getcwd(0, 0)
  exec dst_winnr."wincmd w"

  if vis#sidebar#inside()
    wincmd p
    return
  endif

  let dst_bufnr = bufnr('%')
  let dst_lcd = getcwd(0, 0)
  exec src_bufnr."b"
  if vis#term#inside()
    exec "lcd" src_lcd
  endif

  wincmd p
  exec dst_bufnr."b"
  if vis#term#inside()
    exec "lcd" dst_lcd
  endif
endfunc

func vis#buffer#exchange_dir(dir)
  let nr = vis#window#VisGetWinnr(a:dir)
  call vis#buffer#exchange(nr)
endfunc

"------------------------------------------------------
" buffer copy
"------------------------------------------------------
func vis#buffer#copy(dst_winnr)
  redraw
  let dst_winnr = vis#util#prompt("Winnr? ", a:dst_winnr)
  if dst_winnr == "" || dst_winnr == winnr()
    return
  endif

  let src_bufnr = bufnr('%')
  exec dst_winnr."wincmd w"
  exec src_bufnr."b"
  wincmd p
endfunc

func vis#buffer#copy_dir(dir)
  let nr = vis#window#VisGetWinnr(a:dir)
  call vis#buffer#copy(nr)
endfunc

