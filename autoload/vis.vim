"======================================================
" VisIDE
"======================================================
func vis#let_default_val(var, val)
  exec printf("let %s = exists('%s') ? %s : %d", a:var, a:var, a:var, a:val)
endfunc

func vis#default_term_height()
  let l = float2nr(0.2 * &lines)
  return l < 5 ? 5 : l > 10 ? 10 : l
endfunc

func vis#default_side_width()
  return &columns >= (82 * 2 + 30) ? 30 : 20
endfunc

func vis#default_winwidth_max()
  return float2nr(3.0 / 4.0 * (&columns - g:vis_left_winwidth))
endfunc

"------------------------------------------------------
func vis#init()
  " term                                              ,
  call vis#let_default_val('g:vis_term_winheight'     , vis#default_term_height())
  call vis#let_default_val('g:vis_term_winheight_max' , g:vis_term_winheight * 2)
  " sidebar                                           ,
  call vis#let_default_val('g:vis_left_winwidth'      , vis#default_side_width())
  call vis#let_default_val('g:vis_fern_2nd_winheight' , g:vis_term_winheight)
  " gstatus                                           ,
  call vis#let_default_val('g:vis_gstatus_winheight'  , g:vis_term_winheight)
  " help                                              ,
  call vis#let_default_val('g:vis_help_winwidth'      , 82)
  " width                                             ,
  call vis#let_default_val('g:vis_winwidth_max'       , vis#default_winwidth_max())

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
  elseif vis#sidebar#is_2nd()
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

