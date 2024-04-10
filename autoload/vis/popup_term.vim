"------------------------------------------------------
" popup term
"------------------------------------------------------
func vis#popup_term#open(title, cmd)
  let term_opts = {
    \ 'hidden'      : 1,
    \ 'term_finish' : 'close',
    \ 'term_cols'   : &columns - 20,
    \ 'term_rows'   : &lines - 16,
    \ }
  let buf = term_start(a:cmd, term_opts)

  let title = printf(" %s[%s] ", a:title, a:cmd)
  let win_opts = {
    \ 'title'       : title,
    \ 'padding'     : [0,0,0,0],
    \ 'border'      : [1,1,1,1],
    \ 'borderchars' : ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
    \ 'minwidth'    : &columns - 20,
    \ 'minheight'   : &lines - 16,
    \ }
  call popup_create(buf, win_opts)
endfunc

