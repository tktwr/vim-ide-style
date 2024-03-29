"======================================================
" window
"======================================================
"------------------------------------------------------
" query
"------------------------------------------------------
func vis#window#is_vertical()
  return &columns < 82 ? 1 : 0
endfunc

func vis#window#is_horizontal()
  return &columns >= 82 ? 1 : 0
endfunc

func vis#window#is_fullscreen()
  return &columns > 150 ? 1 : 0
endfunc

"------------------------------------------------------
" move
"------------------------------------------------------
func vis#window#goto(winnr)
  if a:winnr > 0
    exec a:winnr."wincmd w"
  endif
endfunc

"------------------------------------------------------
" maximize window
"------------------------------------------------------
func vis#window#maximize_x_toggle(max_width)
  let w = winwidth(0)
  if !exists('w:orig_width')
    let w:orig_width = w
  endif
  if w == w:orig_width
    let w = a:max_width
  else
    let w = w:orig_width
  endif
  exec "vertical resize" w
endfunc

func vis#window#maximize_y_toggle(max_height)
  let h = winheight(0)
  if !exists('w:orig_height')
    let w:orig_height = h
  endif
  if h == w:orig_height
    let h = a:max_height
  else
    let h = w:orig_height
  endif
  exec "resize" h
endfunc

func vis#window#maximize_xy_toggle(max_width, max_height)
  call vis#window#maximize_x_toggle(a:max_width)
  call vis#window#maximize_y_toggle(a:max_height)
endfunc

"------------------------------------------------------
" resize window
"------------------------------------------------------
func vis#window#resize(height=10)
  exec "resize" a:height
  let w:orig_height = a:height
  set winfixheight
endfunc

func vis#window#vresize(width=82)
  exec "vertical resize" a:width
  let w:orig_width = a:width
endfunc

"------------------------------------------------------
" place window
"------------------------------------------------------
func vis#window#place(place)
  exec "wincmd " a:place
endfunc

"------------------------------------------------------
" quickfix window
"------------------------------------------------------
func vis#window#qf()
  cclose
  exec printf("below cwindow %d", g:vis_term_winheight)
endfunc

"------------------------------------------------------
" close window
"------------------------------------------------------
func vis#window#close_prev_win()
  let curr_winnr = winnr()
  wincmd p
  if exists("*wbl#copy")
    call wbl#copy()
  endif
  close
  exec curr_winnr."wincmd w"
  if exists("*wbl#paste")
    call wbl#paste()
  endif
endfunc

"------------------------------------------------------
" find the first window
"
" return:
"   >0: found winnr
"   -1: not found
"------------------------------------------------------
func vis#window#VisFindFirstWindow(func, begin_winnr=1)
  let curr_winnr = winnr()
  let last_winnr = winnr('$')
  let i = a:begin_winnr
  while i <= last_winnr
    call vis#window#goto(i)
    if a:func(i, curr_winnr)
      call vis#window#goto(curr_winnr)
      return i
    endif
    let i += 1
  endwhile

  call vis#window#goto(curr_winnr)
  return -1
endfunc

"------------------------------------------------------
" find the last window from the current window
"
" return:
"   >0: found winnr
"   -1: not found
"------------------------------------------------------
func vis#window#VisFindLastWindow(func)
  let curr_winnr = winnr()
  let i = curr_winnr
  while i > 0
    call vis#window#goto(i)
    if a:func(i, curr_winnr)
      call vis#window#goto(curr_winnr)
      return i
    endif
    let i -= 1
  endwhile

  call vis#window#goto(curr_winnr)
  return -1
endfunc

"------------------------------------------------------
func vis#window#VisFindFirstTerm(begin_winnr=1)
  return vis#window#VisFindFirstWindow({i, curr_winnr -> &buftype == 'terminal'}, a:begin_winnr)
endfunc

func vis#window#VisFindAltTerm(begin_winnr=1)
  return vis#window#VisFindFirstWindow({i, curr_winnr -> &buftype == 'terminal' && i != curr_winnr}, a:begin_winnr)
endfunc

func vis#window#VisFindFirstEditor(begin_winnr=1)
  return vis#window#VisFindFirstWindow({i, curr_winnr -> &buftype != 'terminal' && !vis#sidebar#inside()}, a:begin_winnr)
endfunc

func vis#window#VisFindLastEditor()
  return vis#window#VisFindLastWindow({i, curr_winnr -> &buftype != 'terminal' && !vis#sidebar#inside()})
endfunc

"------------------------------------------------------
" find an editor
"
" args:
"   winnr == -2: find the first editor window
"   winnr == -1: find the last editor window
"   winnr ==  0: the current window
"   winnr >=  1: the specified window
" return:
"   >0: found winnr
"   -1: not found
"------------------------------------------------------
func vis#window#VisFindEditor(winnr)
  let winnr = a:winnr
  if winnr == -2
    let winnr = vis#window#VisFindFirstEditor()
  elseif winnr == -1
    let winnr = vis#window#VisFindLastEditor()
  endif
  return winnr
endfunc

"------------------------------------------------------
func vis#window#VisGetWinnr(dir)
  let cur_winnr = winnr()
  exec printf("wincmd %s", a:dir)
  let dst_winnr = winnr()

  if dst_winnr != cur_winnr
    wincmd p
  endif

  return dst_winnr
endfunc
