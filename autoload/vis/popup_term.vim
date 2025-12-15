"------------------------------------------------------
" popup term
"------------------------------------------------------
function! vis#popup_term#apply_default_maps(winid) abort
  call win_execute(a:winid, 'tnoremap <silent><buffer> <Plug>(vis-send-C-j) <C-w>.w')
  call win_execute(a:winid, 'tnoremap <silent><buffer> <Plug>(vis-send-C-k) <C-w>.W')
endfunction

func vis#popup_term#open(title, cmd)
  let term_opts = {
    \ 'hidden'      : 1,
    \ 'term_finish' : 'close',
    \ 'term_cols'   : &columns - 20,
    \ 'term_rows'   : &lines - 16,
    \ }
  let buf = term_start(a:cmd, term_opts)
  "call setbufvar(buf, 'vim_ide_style_popup_term', 1)

  let title = printf(" %s[%s] ", a:title, a:cmd)
  let win_opts = {
    \ 'title'       : title,
    \ 'padding'     : [0,0,0,0],
    \ 'border'      : [1,1,1,1],
    \ 'borderchars' : ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
    \ 'minwidth'    : &columns - 20,
    \ 'minheight'   : &lines - 16,
    \ }
  let winid = popup_create(buf, win_opts)

  call win_execute(winid, 'tnoremap <silent><buffer> <C-j> <C-w>.w')
  call win_execute(winid, 'tnoremap <silent><buffer> <C-k> <C-w>.W')
  "call vis#popup_term#apply_default_maps(winid)
endfunc
