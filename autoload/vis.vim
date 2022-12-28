"======================================================
" VisIDE
"======================================================
func vis#init()
  " height
  let g:vis#vis_term_winheight = 10
  let g:vis#vis_gstatus_winheight = 10
  let g:vis#vis_fern_2nd_winheight = 18

  " width
  let g:vis#vis_help_winwidth = 82
  let g:vis#vis_left_winwidth = 30

  let g:vis#vis_tab_labels = {}
  let g:vis#vis_tab_info = ""

  let g:vis#vis_unexpand_env_list = []

  set laststatus=2
  call vis#statusline#setup()
  call vis#tabline#setup()
  call vis#highlight#setup()
  call vis#settings()
endfunc

func vis#settings()
  if exists("g:vis_unexpand_env_list")
    let g:vis#vis_unexpand_env_list = g:vis_unexpand_env_list
  endif
endfunc

"------------------------------------------------------
func vis#VisIDE()
  if winnr('$') == 1
    tcd
    call s:CreateIDE()
  else
    call s:InitSize()
  endif
endfunc

"------------------------------------------------------
" create
"------------------------------------------------------
func s:CreateIDE()
  call vis#sidebar#create()
  wincmd w
  if vis#window#is_fullscreen()
    vsp
    VisTerm
    wincmd w
  endif
  VisTerm
endfunc

"------------------------------------------------------
" init size
"------------------------------------------------------
func s:InitSizeForEachWin()
  if &buftype == 'terminal'
    exec "resize" g:vis#vis_term_winheight
  elseif winnr() == 2 && &filetype == 'fern'
    exec "resize" g:vis#vis_fern_2nd_winheight
  endif
endfunc

func s:InitSize()
  1wincmd w
  exec "normal \<C-W>="
  exec "vertical resize" g:vis#vis_left_winwidth
  2,$windo call s:InitSizeForEachWin()
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

