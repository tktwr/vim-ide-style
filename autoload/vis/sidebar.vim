"======================================================
" side bar
"======================================================
func vis#sidebar#create()
  call vis#external#fern#open_drawer_toggle()
  below split
  exec "resize" g:vis#vis_fern_2nd_winheight
endfunc

func vis#sidebar#toggle()
  1wincmd w
  if winwidth(0) < 5
    exec "vertical resize" g:vis#vis_left_winwidth
  else
    exec "vert resize 0"
  endif
  wincmd p
endfunc

func vis#sidebar#inside()
  let winnr = winnr()
  if (winnr <= 2 && winwidth(0) <= g:vis#vis_left_winwidth)
    return 1
  else
    return 0
  endif
endfunc

