"======================================================
" fern
"======================================================
func s:VisFernRoot()
  let helper = fern#helper#new()
  let node = helper.sync.get_root_node()
  return node._path
endfunc

func s:VisFernSelected()
  let helper = fern#helper#new()
  let node = helper.sync.get_cursor_node()
  return node._path
endfunc

"------------------------------------------------------
func s:VisFernEditItem(winnr)
  let selected = s:VisFernSelected()
  if (selected == "")
    return
  endif

  call bmk#Edit(selected, a:winnr)
endfunc

func s:VisFernPreviewItem(winnr)
  let selected = s:VisFernSelected()
  if (isdirectory(selected))
    exec "normal \<Plug>(fern-action-expand)"
  elseif selected != ""
    let prev_winnr = winnr()
    call bmk#Edit(selected, a:winnr)
    exec prev_winnr."wincmd w"
  endif
endfunc

"------------------------------------------------------
func s:VisFernPrintItem()
  let key = s:VisFernSelected()
  if (len(key) > g:fern#drawer_width / 2)
    echo key
  else
    echo ""
  endif
endfunc

func s:VisFernPrevItem()
  normal -
  call s:VisFernPrintItem()
endfunc

func s:VisFernNextItem()
  normal +
  call s:VisFernPrintItem()
endfunc

"------------------------------------------------------
func vis#external#fern#find_drawer()
  call vis#window#goto(1)

  if exists('w:vis_fern_init_buf') && &filetype != 'fern'
    exec w:vis_fern_init_buf.'b'
  endif
endfunc

" options:
"   drawer: '-drawer'
"   toggle: '-toggle'
func vis#external#fern#open(dir, drawer='', toggle='')
  let dir = expand(a:dir)
  let dir = substitute(dir, ' ', '\\ ', 'g')
  let reveal = '-reveal='.expand('%')
  let drawer = a:drawer
  let toggle = a:toggle

  if &filetype == 'fern'
    let reveal = ''
  endif

  if (vis#sidebar#inside() && winnr() == 1)
    let drawer = '-drawer'
  endif

  if drawer == '-drawer'
    call vis#external#fern#find_drawer()
  endif

  let cmd = printf('Fern %s %s %s %s', dir, reveal, drawer, toggle)
  exec cmd
  exec "lcd" dir

  if !exists('w:vis_fern_init_buf')
    let w:vis_fern_init_buf = bufnr('%')
  endif
endfunc

func vis#external#fern#open_drawer_toggle()
  call vis#external#fern#open('.', '-drawer', '-toggle')
endfunc

func vis#external#fern#open_drawer(dir)
  call vis#external#fern#open(a:dir, '-drawer', '')
endfunc

func vis#external#fern#lcd_here()
  let selected = s:VisFernSelected()
  let dir = bmk#util#GetDirName(selected)
  exec "lcd" dir
endfunc

"------------------------------------------------------
func vis#external#fern#VisFernOpenItem()
  let selected = s:VisFernSelected()
  call bmk#Open(selected, 0)
endfunc

func vis#external#fern#VisFernViewItem()
  let selected = s:VisFernSelected()
  call bmk#View(selected, 0)
endfunc

"------------------------------------------------------
func vis#external#fern#VisFernSaveItem()
  let selected = s:VisFernSelected()
  call cpm#io#SaveURL(selected)
endfunc

"------------------------------------------------------
function! vis#external#fern#map() abort
  nmap <buffer><expr>
        \ <Plug>(my-fern-select-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )

  nmap <buffer> <2-LeftMouse> <Plug>(my-fern-select-expand-collapse)
  nmap <buffer> <CR>          <Plug>(my-fern-select-expand-collapse)
  nmap <buffer> <C-CR>        :call vis#external#fern#VisFernViewItem()<CR>
  nmap <buffer> <S-CR>        :call vis#external#fern#VisFernOpenItem()<CR>
  nmap <buffer> <C-.>         :call vis#external#fern#lcd_here()<CR>

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
  nmap <buffer> l     :call <SID>VisFernPreviewItem(-2)<CR>
  nmap <buffer> j     :call <SID>VisFernNextItem()<CR>
  nmap <buffer> k     :call <SID>VisFernPrevItem()<CR>

  nmap <buffer> 2     :call <SID>VisFernEditItem(2)<CR>
  nmap <buffer> 3     :call <SID>VisFernEditItem(3)<CR>
  nmap <buffer> 4     :call <SID>VisFernEditItem(4)<CR>
  nmap <buffer> 5     :call <SID>VisFernEditItem(5)<CR>
  nmap <buffer> 6     :call <SID>VisFernEditItem(6)<CR>
  nmap <buffer> 7     :call <SID>VisFernEditItem(7)<CR>
  nmap <buffer> 8     :call <SID>VisFernEditItem(8)<CR>
  nmap <buffer> 9     :call <SID>VisFernEditItem(9)<CR>

  nmap <silent> <buffer> <Space> :CpmOpen<CR>

  nmap <buffer><nowait> < <Plug>(fern-action-leave)
  nmap <buffer><nowait> > <Plug>(fern-action-enter)
endfunction

