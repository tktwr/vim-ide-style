"------------------------------------------------------
" popup term
"------------------------------------------------------
func vis#popup_term#open(title, cmd)
  call vis#buffer#lcd_here()

  let title = printf(" %s ", a:title)
  let term_opts = {
    \ 'hidden'      : 1,
    \ 'term_finish' : 'close',
    \ }
  let buf = term_start(a:cmd, term_opts)

  let win_opts = {
    \ 'title'       : title,
    \ 'padding'     : [0,0,0,0],
    \ 'border'      : [1,1,1,1],
    \ 'borderchars' : ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
    \ 'minwidth'  : &columns - 20,
    \ 'minheight' : &lines - 20,
    \ }
  call popup_create(buf, win_opts)
endfunc

