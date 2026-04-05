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
  exec "resize" 10
  setl winfixheight
endfunc

func vis#sidebar#create_3()
  call vis#external#fern#open_drawer_toggle()
  let w:is_sidebar = 1

  below split
  let w:is_sidebar = 1
  exec "resize" 10
  setl winfixheight

  below split
  let w:is_sidebar = 1
  exec "resize" 10
  setl winfixheight
endfunc

func vis#sidebar#add()
  below split
  let w:is_sidebar = 1
  exec "resize" 10
  setl winfixheight
endfunc

func vis#sidebar#toggle()
  1wincmd w
  if winwidth(0) < 5
    exec "vert resize" g:vis_left_winwidth
  else
    exec "vert resize 0"
  endif
  wincmd p
endfunc

func vis#sidebar#inside()
  if (exists('w:is_sidebar') && w:is_sidebar == 1)
    return 1
  endif
  return 0
endfunc

