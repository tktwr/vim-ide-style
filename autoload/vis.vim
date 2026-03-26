"======================================================
" VisIDE
"======================================================
func vis#let_default_val(var, val)
  exec printf("let %s = exists('%s') ? %s : %d", a:var, a:var, a:var, a:val)
endfunc

"------------------------------------------------------
func vis#init()
  " help                                              ,
  call vis#let_default_val('g:vis_help_winwidth'      , 82)
  " sidebar                                           ,
  call vis#let_default_val('g:vis_left_winwidth'      , 30)
  " term                                              ,
  call vis#let_default_val('g:vis_term_winheight'     , 10)
  " gstatus                                           ,
  call vis#let_default_val('g:vis_gstatus_winheight'  , 10)

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
func vis#ide(type=0)
  if winnr('$') == 1
    tcd
    call s:create_ide(a:type)
    call s:resize_all()
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
    call s:create_ide_1v()
  else
    if a:type == 0
      if &columns > 300
        let l:type = 3
      elseif &columns > 200
        let l:type = 2
      else
        let l:type = 1
      endif
    else
        let l:type = a:type
    endif
    if l:type == 3
      call s:create_ide_3h()
    elseif l:type == 2
      call s:create_ide_2h()
    elseif l:type == 1
      call s:create_ide_1h()
    endif
  endif
endfunc

" +-----+
" +-----+
" |     |
" +-----+
" +-----+
func s:create_ide_1v()
  let t:ide = 1

  call vis#sidebar#create_v()

  $wincmd w
  below VisTerm
endfunc

" +-+--+
" | |  |
" +-+  |
" | +--+
" +-+--+
func s:create_ide_1h()
  let t:ide = 1

  call vis#sidebar#create()

  $wincmd w
  below VisTerm
endfunc

" +-+--+--+
" | |  |  |
" +-+  |  |
" | +--+--+
" +-+--+--+
func s:create_ide_2h()
  let t:ide = 1

  call vis#sidebar#create()

  $wincmd w
  vsp
  below VisTerm

  $wincmd w
  below VisTerm
endfunc

" +-+--+--+--+
" |1|3 |5 |7 |
" | |  |  |  |
" +-+  |  |  |
" | +--+--+--+
" |2|4 |6 |8 |
" +-+--+--+--+
func s:create_ide_3h()
  let t:ide = 1

  call vis#sidebar#create()

  $wincmd w
  vsp
  below VisTerm

  $wincmd w
  vsp
  below VisTerm

  $wincmd w
  VisTerm

  $wincmd w
  VisWinResize 10
  VisWinVResize 80
endfunc

"------------------------------------------------------
" resize
"------------------------------------------------------
func s:resize_all()
  1wincmd w
  exec "normal \<C-W>="
  exec "vertical resize" g:vis_left_winwidth
endfunc

"------------------------------------------------------
" store size
"------------------------------------------------------
func s:store_size_each()
  if !exists('w:orig_width')
    let w:orig_width = winwidth(0)
  endif
  if !exists('w:orig_height')
    let w:orig_height = winheight(0)
  endif
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

