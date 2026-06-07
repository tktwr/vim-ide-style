"======================================================
" side bar
"======================================================
func vis#sidebar#create_v()
  sp
  let w:is_sidebar = 1
  Fern .
  VisWinResize 6
endfunc

func vis#sidebar#create()
  call vis#external#fern#open_drawer_toggle()
  let w:is_sidebar = 1
endfunc

func vis#sidebar#add(height=10)
  below split
  let w:is_sidebar = 1
  call vis#window#resize(a:height)
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

