"======================================================
" side bar
"======================================================
func vis#sidebar#create_v()
  sp
  Fern .
  VisWinResize 6
endfunc

func vis#sidebar#create()
  call vis#external#fern#open_drawer_toggle()
  below split
  exec "resize" g:vis_fern_2nd_winheight
  set winfixheight
endfunc

func vis#sidebar#toggle()
  1wincmd w
  if winwidth(0) < 5
    exec "vertical resize" g:vis_left_winwidth
  else
    exec "vert resize 0"
  endif
  wincmd p
endfunc

func vis#sidebar#inside()
  if vis#window#is_vertical()
    if (winnr() == 1)
      return 1
    endif
  else
    if (winnr() <= 2 && winwidth(0) <= g:vis_left_winwidth)
      return 1
    endif
  endif
  return 0
endfunc

func vis#sidebar#is_2nd()
  if (winnr() == 2 && winwidth(0) <= g:vis_left_winwidth)
    return 1
  else
    return 0
  endif
endfunc

