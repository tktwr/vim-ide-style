"======================================================
" VisIDE
"======================================================
func vis#init()
  " height
  let g:vis_term_winheight = 10
  let g:vis_gstatus_winheight = 10
  let g:vis_fern_2nd_winheight = 20

  " width
  let g:vis_help_winwidth = 82
  let g:vis_left_winwidth = 30

  let g:vis_tab_labels = {}
  let g:vis_tab_info = ""

  if !exists('g:vis_unexpand_env_list')
    let g:vis_unexpand_env_list = []
  endif

  set laststatus=2
  call vis#statusline#setup()
  call vis#tabline#setup()
  call vis#highlight#setup()
endfunc

"------------------------------------------------------
func vis#ide()
  if winnr('$') == 1
    tcd
    call s:create_ide()
  else
    call s:resize_all()
  endif
  call s:store_size_all()
endfunc

func vis#redraw()
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

"------------------------------------------------------
" create
"------------------------------------------------------
func s:create_ide()
  if vis#window#is_vertical()
    call s:create_ide_v()
  else
    call s:create_ide_h()
  endif
endfunc

func s:create_ide_v()
  let t:ide = 1
  sp
  Fern .
  resize 6
  wincmd w
  below VisTerm
endfunc

func s:create_ide_h()
  let t:ide = 1
  call vis#sidebar#create()
  wincmd w
  if vis#window#is_fullscreen()
    vsp
    below VisTerm
    wincmd w
  endif
  below VisTerm
endfunc

"------------------------------------------------------
" resize
"------------------------------------------------------
func s:resize_each()
  if &buftype == 'terminal'
    exec "resize" g:vis_term_winheight
  elseif winnr() == 2 && &filetype == 'fern'
    exec "resize" g:vis_fern_2nd_winheight
  endif
endfunc

func s:resize_all()
  1wincmd w
  exec "normal \<C-W>="
  exec "vertical resize" g:vis_left_winwidth
  2,$windo call s:resize_each()
endfunc

"------------------------------------------------------
" store size
"------------------------------------------------------
func s:store_size_each()
  let w:orig_width = winwidth(0)
  let w:orig_height = winheight(0)
endfunc

func s:store_size_all()
  1,$windo call s:store_size_each()
endfunc

