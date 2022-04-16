"======================================================
" fern
"======================================================

func vis#external#fern#MyFernDrawerOpen()
  call vis#window#TtGotoWinnr(1)

  if exists('w:my_fern_init_buf') && &filetype != 'fern'
    exec w:my_fern_init_buf.'b'
  endif
endfunc

" options:
"   drawer: '-drawer'
"   toggle: '-toggle'
func vis#external#fern#MyFern(dir, drawer='', toggle='')
  let dir = expand(a:dir)
  let dir = substitute(dir, ' ', '\\ ', 'g')
  let drawer = a:drawer
  let toggle = a:toggle

  if (vis#sidebar#TtInSideBar() && winnr() == 1)
    let drawer = '-drawer'
  endif

  if drawer == '-drawer'
    call vis#external#fern#MyFernDrawerOpen()
  endif

  let cmd = printf('Fern %s -reveal=%% %s %s', dir, drawer, toggle)
  exec cmd

  if !exists('w:my_fern_init_buf')
    let w:my_fern_init_buf = bufnr('%')
  endif
endfunc

func vis#external#fern#MyFernDrawerToggle()
  call vis#external#fern#MyFern('.', '-drawer', '-toggle')
endfunc

func vis#external#fern#MyFernDrawer(dir)
  call vis#external#fern#MyFern(a:dir, '-drawer', '')
endfunc

"------------------------------------------------------
func s:MyFernRoot()
  let helper = fern#helper#new()
  let node = helper.sync.get_root_node()
  return node._path
endfunc

func s:MyFernSelected()
  let helper = fern#helper#new()
  let node = helper.sync.get_cursor_node()
  return node._path
endfunc

func s:MyFernEditItem(winnr)
  let selected = s:MyFernSelected()
  if (selected == "")
    return
  endif

  call bmk#BmkEdit(selected, a:winnr)
endfunc

func s:MyFernPreviewItem(winnr)
  let selected = s:MyFernSelected()
  if (isdirectory(selected))
    exec "normal \<Plug>(fern-action-expand)"
  elseif selected != ""
    let prev_winnr = winnr()
    call bmk#BmkEdit(selected, a:winnr)
    exec prev_winnr."wincmd w"
  endif
endfunc

"------------------------------------------------------
func vis#external#fern#MyFernOpenItem()
  let selected = s:MyFernSelected()
  call bmk#BmkOpen(selected, 0)
endfunc

func vis#external#fern#MyFernViewItem()
  let selected = s:MyFernSelected()
  call bmk#BmkView(selected, 0)
endfunc

"------------------------------------------------------
func s:MyFernPrintItem()
  let key = s:MyFernSelected()
  if (len(key) > g:fern#drawer_width / 2)
    echo key
  else
    echo ""
  endif
endfunc

func s:MyFernPrevItem()
  normal -
  call s:MyFernPrintItem()
endfunc

func s:MyFernNextItem()
  normal +
  call s:MyFernPrintItem()
endfunc

"------------------------------------------------------
function! vis#external#fern#MyFernMap() abort
  nmap <buffer><expr>
        \ <Plug>(my-fern-select-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )

  nmap <buffer> <2-LeftMouse> <Plug>(my-fern-select-expand-collapse)
  nmap <buffer> <CR>          <Plug>(my-fern-select-expand-collapse)
  nmap <buffer> <C-CR>        :call vis#external#fern#MyFernViewItem()<CR>
  nmap <buffer> <S-CR>        :call vis#external#fern#MyFernOpenItem()<CR>

  nmap <buffer> N     <Plug>(fern-action-new-path)
  nmap <buffer> D     <Plug>(fern-action-remove)
  nmap <buffer> M     <Plug>(fern-action-move)
  nmap <buffer> R     <Plug>(fern-action-rename)

  nmap <buffer> <C-G> <Plug>(fern-action-reload)
  nmap <buffer> ?     <Plug>(fern-action-help)
  nmap <buffer> !     <Plug>(fern-action-hidden)
  nmap <buffer> m     <Plug>(fern-action-mark)
  nmap <buffer> s     <Plug>(fern-action-open:split)
  nmap <buffer> v     <Plug>(fern-action-open:vsplit)

  nmap <buffer> h     <Plug>(fern-action-collapse)
  nmap <buffer> l     :call <SID>MyFernPreviewItem(-2)<CR>
  nmap <buffer> j     :call <SID>MyFernNextItem()<CR>
  nmap <buffer> k     :call <SID>MyFernPrevItem()<CR>

  nmap <buffer> 2     :call <SID>MyFernEditItem(2)<CR>
  nmap <buffer> 3     :call <SID>MyFernEditItem(3)<CR>
  nmap <buffer> 4     :call <SID>MyFernEditItem(4)<CR>
  nmap <buffer> 5     :call <SID>MyFernEditItem(5)<CR>
  nmap <buffer> 6     :call <SID>MyFernEditItem(6)<CR>
  nmap <buffer> 7     :call <SID>MyFernEditItem(7)<CR>
  nmap <buffer> 8     :call <SID>MyFernEditItem(8)<CR>
  nmap <buffer> 9     :call <SID>MyFernEditItem(9)<CR>

  nmap <silent> <buffer> <Space> :CpmOpen<CR>

  nmap <buffer><nowait> < <Plug>(fern-action-leave)
  nmap <buffer><nowait> > <Plug>(fern-action-enter)
endfunction

function! vis#external#fern#MyFernSyntax() abort
  syn match  fernCPP          ".*.cpp\ze.*$"
  syn match  fernC            ".*.c\ze.*$"
  syn match  fernH            ".*.h\ze.*$"
  syn match  fernPY           ".*.py\ze.*$"
  syn match  fernSH           ".*.sh\ze.*$"
  syn match  fernVIM          ".*.vim\ze.*$"
  syn match  fernHTML         ".*.html\ze.*$"
  syn match  fernGLB          ".*.glb\ze.*$"
  syn match  fernCMakeLists   ".*CMakeLists.txt\ze.*$"
  syn match  fernMakefile     ".*Makefile\ze.*$"
  syn match  fernMakeSH       ".*make.*.sh\ze.*$"

  hi link fernCPP        MyGreen
  hi link fernC          MyGreen
  hi link fernH          MyAqua
  hi link fernPY         MyYellow
  hi link fernSH         MyPurple
  "hi link fernVIM        MyGreen
  hi link fernHTML       MyYellow
  hi link fernGLB        MyAqua
  hi link fernCMakeLists MyOrange
  hi link fernMakefile   MyOrange
  hi link fernMakeSH     MyOrange
endfunction

function! vis#external#fern#MyFernHighlight() abort
  hi link FernRootSymbol     MyRed
  hi link FernRootText       MyRed
  hi link FernBranchSymbol   MyRed
  hi link FernBranchText     MyRed
endfunction

