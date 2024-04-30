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
  call vis#let_default_val('g:vis_fern_2nd_winheight' , g:vis_term_winheight * 2)
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

  if !exists('g:vis_memo_bmk_file')
    let g:vis_memo_bmk_file = '~/tags.bmk'
  endif

  set laststatus=2
  call vis#statusline#setup()
  call vis#tabline#setup()
  call vis#highlight#setup()

  if !exists('g:wbl_max')
    let g:wbl_max = 10
  endif
endfunc

"------------------------------------------------------
func vis#ide(type=1)
  if winnr('$') == 1
    tcd
    call s:create_ide(a:type)
  else
    call s:resize_all()
  endif
  call s:store_size_all()
  call s:reload_all()
endfunc

func vis#redraw()
  redraw!
  set invnumber
  set invlist
  call quickhl#manual#reset()
  let l:dir = getcwd(0, 0)
  let l:file = expand("%")
  echo printf("%s [%s]", l:file, l:dir)
  "file
  IndentGuidesToggle
endfunc

"------------------------------------------------------
" create
"------------------------------------------------------
func s:create_ide(type)
  if vis#window#is_vertical()
    call s:create_ide_v()
  else
    if a:type == 2
      call s:create_ide_h_2()
    else
      call s:create_ide_h()
    endif
  endif
endfunc

" +-----+
" +-----+
" |     |
" +-----+
" +-----+
func s:create_ide_v()
  let t:ide = 1
  call vis#sidebar#create_v()
  wincmd w
  below VisTerm
endfunc

" +-+--+--+
" | |  |  |
" +-+  |  |
" | +--+--+
" +-+--+--+
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

" +-+--+--+
" | |  |  |
" +-+-----+
" | +-----+
" +-+-----+
func s:create_ide_h_2()
  let t:ide = 1
  call vis#sidebar#create()
  wincmd w
  if vis#window#is_fullscreen()
    below VisTerm
    VisWinResize 5
    wincmd W
    below new
    VisWinResize 5
    wincmd W
    vsp
  endif
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

"------------------------------------------------------
" reload
"------------------------------------------------------
func s:reload_each()
  if &buftype != 'terminal'
    if &filetype == 'fern'
      exec "normal \<Plug>(fern-action-reload)"
    elseif &filetype != ''
      exec 'edit'
    endif
  endif
endfunc

func s:reload_all()
  1,$windo call s:reload_each()
endfunc

