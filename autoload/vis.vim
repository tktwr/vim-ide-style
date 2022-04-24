"======================================================
" VisIDE
"======================================================
func vis#VisInit()
  let g:vis#vis_term_winheight = 10
  let g:vis#vis_gstatus_winheight = 10
  let g:vis#vis_fern_2nd_winheight = 18
  let g:vis#vis_help_winwidth = 82
  let g:vis#vis_left_winwidth = 30

  let g:vis#vis_tab_labels = {}
  let g:vis#vis_tab_info = ""
endfunc

func vis#VisIDE()
  let l:is_fullscreen = vis#window#VisIsFullscreen()
  call vis#sidebar#VisMakeSideBar()
  wincmd w
  if l:is_fullscreen
    vsp
    VisTerm
    wincmd w
  endif
  VisTerm
endfunc

"------------------------------------------------------
" init size
"------------------------------------------------------
func s:VisWinInitSizeForEachWin()
  if &buftype == 'terminal'
    exec "resize" g:vis#vis_term_winheight
  elseif winnr() == 2 && &filetype == 'fern'
    exec "resize" g:vis#vis_fern_2nd_winheight
  endif
endfunc

func vis#VisWinInitSize()
  1wincmd w
  exec "normal \<C-W>="
  exec "vertical resize" g:vis#vis_left_winwidth
  2,$windo call s:VisWinInitSizeForEachWin()
endfunc

"------------------------------------------------------
" redraw
"------------------------------------------------------
func vis#VisRedraw()
  redraw!
  set invnumber
  set invlist
  call quickhl#manual#reset()
  nohlsearch
  let l:dir = getcwd()
  let l:file = expand("%")
  echo printf("%s [%s]", l:file, l:dir)
  "file
  IndentGuidesToggle
endfunc

