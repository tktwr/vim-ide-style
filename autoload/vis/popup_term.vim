"------------------------------------------------------
" popup term
"------------------------------------------------------
func vis#popup_term#open(title, cmd)
  call vis#buffer#lcd_here()
  let dir = getcwd(0, 0)
  let cmd = printf("%s %s", a:cmd, dir)

  let term_opts = {
    \ 'hidden'      : 1,
    \ 'term_finish' : 'close',
    \ 'term_cols'   : &columns - 20,
    \ 'term_rows'   : &lines - 20,
    \ }
  let buf = term_start(cmd, term_opts)

  let title = printf(" %s [%s] ", a:title, dir)
  let win_opts = {
    \ 'title'       : title,
    \ 'padding'     : [0,0,0,0],
    \ 'border'      : [1,1,1,1],
    \ 'borderchars' : ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
    \ 'minwidth'    : &columns - 20,
    \ 'minheight'   : &lines - 20,
    \ }
  call popup_create(buf, win_opts)
endfunc

