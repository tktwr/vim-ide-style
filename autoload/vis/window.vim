"======================================================
" window
"======================================================
"------------------------------------------------------
" query
"------------------------------------------------------
func vis#window#TtIsFullscreen()
  if &columns > 150
    return 1
  else
    return 0
  endif
endfunc

"------------------------------------------------------
" move
"------------------------------------------------------
func vis#window#TtGotoWinnr(winnr)
  if a:winnr > 0
    exec a:winnr."wincmd w"
  endif
endfunc

"------------------------------------------------------
" maximize window
"------------------------------------------------------
func vis#window#MyWinMaximizeXToggle(max_width)
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

func vis#window#MyWinMaximizeYToggle(max_height)
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

func vis#window#MyWinMaximizeXYToggle(max_width, max_height)
  call vis#window#MyWinMaximizeXToggle(a:max_width)
  call vis#window#MyWinMaximizeYToggle(a:max_height)
endfunc

"------------------------------------------------------
" resize window
"------------------------------------------------------
func vis#window#MyWinResize(height)
  exec "resize" a:height
  let w:orig_height = a:height
endfunc

func vis#window#MyWinVResize(width)
  exec "vertical resize" a:width
  let w:orig_width = a:width
endfunc

"------------------------------------------------------
" place window
"------------------------------------------------------
func vis#window#MyWinPlace(place)
  exec "wincmd " a:place
endfunc

"------------------------------------------------------
" close window
"------------------------------------------------------
func vis#window#MyClosePrevWin()
  let curr_winnr = winnr()
  wincmd p
  call wbl#WblCopy()
  close
  exec curr_winnr."wincmd w"
  call wbl#WblPaste()
endfunc

"------------------------------------------------------
" find the first terminal window
"------------------------------------------------------
func vis#window#TtFindFirstTerm(begin_winnr=1)
  let curr_winnr = winnr()
  let last_winnr = winnr('$')
  let i = a:begin_winnr
  while i <= last_winnr
    call vis#window#TtGotoWinnr(i)
    if &buftype == 'terminal'
      call vis#window#TtGotoWinnr(curr_winnr)
      return i
    endif
    let i += 1
  endwhile

  call vis#window#TtGotoWinnr(curr_winnr)
  return -1
endfunc

"------------------------------------------------------
" find the first editor window
"------------------------------------------------------
func vis#window#TtFindFirstEditor(begin_winnr=1)
  let curr_winnr = winnr()
  let last_winnr = winnr('$')
  let i = a:begin_winnr
  while i <= last_winnr
    call vis#window#TtGotoWinnr(i)
    if !vis#sidebar#TtInSideBar() && &buftype != 'terminal'
      call vis#window#TtGotoWinnr(curr_winnr)
      return i
    endif
    let i += 1
  endwhile

  call vis#window#TtGotoWinnr(curr_winnr)
  return -1
endfunc

"------------------------------------------------------
" find the last editor window from the current window
"------------------------------------------------------
func vis#window#TtFindLastEditor()
  let curr_winnr = winnr()
  let i = curr_winnr
  while i > 0
    call vis#window#TtGotoWinnr(i)
    if !vis#sidebar#TtInSideBar() && &buftype != 'terminal'
      call vis#window#TtGotoWinnr(curr_winnr)
      return i
    endif
    let i -= 1
  endwhile

  call vis#window#TtGotoWinnr(curr_winnr)
  return -1
endfunc

"------------------------------------------------------
" find an editor
"------------------------------------------------------
" winnr == -2: the first editor window
" winnr == -1: the last editor window
" winnr ==  0: the current window
" winnr >=  1: the specified window
func vis#window#TtFindEditor(winnr)
  let winnr = a:winnr
  if winnr == -2
    let winnr = vis#window#TtFindFirstEditor()
  elseif winnr == -1
    let winnr = vis#window#TtFindLastEditor()
  endif
  return winnr
endfunc

