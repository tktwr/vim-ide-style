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
  let w:is_sidebar = 1

  below split
  let w:is_sidebar = 1
  exec "resize" 20
  set winfixheight
endfunc

func vis#sidebar#create_3()
  call vis#external#fern#open_drawer_toggle()
  let w:is_sidebar = 1

  below split
  let w:is_sidebar = 1
  exec "resize" 10
  set winfixheight

  below split
  let w:is_sidebar = 1
  exec "resize" 10
  set winfixheight
endfunc

func vis#sidebar#add()
  below split
  let w:is_sidebar = 1
  exec "resize" 20
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
    if (exists('w:is_sidebar') && w:is_sidebar == 1)
      return 1
    endif
  endif
  return 0
endfunc

