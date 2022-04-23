"======================================================
" side bar
"======================================================
func vis#sidebar#VisMakeSideBar()
  call vis#external#fern#VisFernDrawerToggle()
  below split
  exec "resize" g:my_fern_2nd_winheight
endfunc

func vis#sidebar#VisSideBarToggle()
  1wincmd w
  if winwidth(0) < 5
    exec "vertical resize" g:my_left_winwidth
  else
    exec "vert resize 0"
  endif
  wincmd p
endfunc

func vis#sidebar#VisInSideBar()
  let winnr = winnr()
  if (winnr <= 2 && winwidth(0) <= g:my_left_winwidth)
    return 1
  else
    return 0
  endif
endfunc

