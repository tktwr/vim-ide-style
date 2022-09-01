"======================================================
" window
"======================================================
"------------------------------------------------------
" query
"------------------------------------------------------
func vis#window#VisIsFullscreen()
  if &columns > 150
    return 1
  else
    return 0
  endif
endfunc

"------------------------------------------------------
" move
"------------------------------------------------------
func vis#window#VisGotoWinnr(winnr)
  if a:winnr > 0
    exec a:winnr."wincmd w"
  endif
endfunc

"------------------------------------------------------
" maximize window
"------------------------------------------------------
func vis#window#VisWinMaximizeXToggle(max_width)
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

func vis#window#VisWinMaximizeYToggle(max_height)
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

func vis#window#VisWinMaximizeXYToggle(max_width, max_height)
  call vis#window#VisWinMaximizeXToggle(a:max_width)
  call vis#window#VisWinMaximizeYToggle(a:max_height)
endfunc

"------------------------------------------------------
" resize window
"------------------------------------------------------
func vis#window#VisWinResize(height)
  exec "resize" a:height
  let w:orig_height = a:height
endfunc

func vis#window#VisWinVResize(width)
  exec "vertical resize" a:width
  let w:orig_width = a:width
endfunc

"------------------------------------------------------
" place window
"------------------------------------------------------
func vis#window#VisWinPlace(place)
  exec "wincmd " a:place
endfunc

"------------------------------------------------------
" close window
"------------------------------------------------------
func vis#window#VisClosePrevWin()
  let curr_winnr = winnr()
  wincmd p
  if exists("*wbl#WblCopy")
    call wbl#WblCopy()
  endif
  close
  exec curr_winnr."wincmd w"
  if exists("*wbl#WblPaste")
    call wbl#WblPaste()
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
    call vis#window#VisGotoWinnr(i)
    if a:func(i, curr_winnr)
      call vis#window#VisGotoWinnr(curr_winnr)
      return i
    endif
    let i += 1
  endwhile

  call vis#window#VisGotoWinnr(curr_winnr)
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
    call vis#window#VisGotoWinnr(i)
    if a:func(i, curr_winnr)
      call vis#window#VisGotoWinnr(curr_winnr)
      return i
    endif
    let i -= 1
  endwhile

  call vis#window#VisGotoWinnr(curr_winnr)
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
  return vis#window#VisFindFirstWindow({i, curr_winnr -> &buftype != 'terminal' && !vis#sidebar#VisInSideBar()}, a:begin_winnr)
endfunc

func vis#window#VisFindLastEditor()
  return vis#window#VisFindLastWindow({i, curr_winnr -> &buftype != 'terminal' && !vis#sidebar#VisInSideBar()})
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

