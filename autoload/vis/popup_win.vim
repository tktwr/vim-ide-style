func vis#popup_win#width()
  let w = &columns / 2
  if w < 80
    let w = &columns - 20
  endif
  return w
endfunc

func vis#popup_win#height()
  let h = &lines / 2
  if h < 20
    let h = &lines - 10
  endif
  return h
endfunc

"------------------------------------------------------
" popup_win for vim
"------------------------------------------------------
func vis#popup_win#filter(id, key)
  return popup_filter_menu(a:id, a:key)
endfunc

func vis#popup_win#callback(id, result)
endfunc

func vis#popup_win#open_vim(title, list, callback, filter)
  let title = printf(" %s ", a:title)
  let w = vis#popup_win#width()
  let h = vis#popup_win#height()

  let opt = {
    \ 'title'       : title,
    \ 'callback'    : a:callback,
    \ 'filter'      : a:filter,
    \ 'padding'     : [0,0,0,0],
    \ 'border'      : [1,1,1,1],
    \ 'borderchars' : ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
    \ 'minwidth'    : w,
    \ 'maxwidth'    : w,
    \ 'minheight'   : h,
    \ 'maxheight'   : h,
    \ }
  return popup_menu(a:list, opt)
endfunc

"------------------------------------------------------
" popup_win for nvim
"------------------------------------------------------
func vis#popup_win#callback_str(str)
endfunc

func vis#popup_win#open_nvim(title, list, callback)
  let w = vis#popup_win#width()
  let h = vis#popup_win#height()
  let x = (&columns - w) / 2
  let y = (&lines - h) / 2
	let opts = {
				\ 'relative' : 'editor',
				\ 'col'      : x,
				\ 'row'      : y,
				\ 'width'    : w,
				\ 'height'   : h,
				\ 'border'   : 'rounded',
				\ }
  let winid = popup_menu#open_(a:list, opts, function(a:callback))
  set signcolumn=auto
  return winid
endfunc

"------------------------------------------------------
" popup_win
"------------------------------------------------------
func vis#popup_win#open(title, list, callback='', filter='')
  if exists('*popup_menu')
    " vim 8.1
    let callback = a:callback == '' ? 'vis#popup_win#callback' : a:callback
    let filter = a:filter == '' ? 'vis#popup_win#filter' : a:filter
    let winid = vis#popup_win#open_vim(a:title, a:list, callback, filter)
  elseif has('nvim') && exists('g:loaded_popup_menu')
    " nvim with the plugin 'Ajnasz/vim-popup-menu'
    let callback = a:callback == '' ? 'vis#popup_win#callback_str' : a:callback
    let winid = vis#popup_win#open_nvim(a:title, a:list, callback)
  endif
  call win_execute(winid, 'setl syntax=txt')
  return winid
endfunc

func vis#popup_win#has()
  if exists('*popup_menu')
    return 1
  elseif has('nvim') && exists('g:loaded_popup_menu')
    return 1
  endif
  return 0
endfunc

