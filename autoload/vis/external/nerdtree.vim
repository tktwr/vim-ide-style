"======================================================
" nerdtree
"======================================================

let s:bmk_winwidth = 30
if exists("g:bmk_winwidth")
  let s:bmk_winwidth = g:bmk_winwidth
endif

"------------------------------------------------------

func vis#external#nerdtree#MyNERDTreeToggle()
  if (&filetype == "nerdtree")
    NERDTreeToggle
  elseif (&filetype == "")
    NERDTree
  else
    vis#external#nerdtree#MyNERDTreeFind("%:p:h")
  endif
endfunc

func vis#external#nerdtree#MyNERDTreeFind(dir)
  let dir = expand(a:dir)
  call wbl#WblFind('NERD_tree', 1)
  exec "NERDTreeFind" dir
endfunc

"------------------------------------------------------
func s:MyNERDTreeSelected()
  let n = g:NERDTreeFileNode.GetSelected()
  if n != {}
    return n.path.str()
  endif
  return ""
endfunc

func s:MyNERDTreeEditItem(winnr)
  let selected = s:MyNERDTreeSelected()
  if (selected == "")
    return
  endif

  call bmk#BmkEdit(selected, a:winnr)
endfunc

func s:MyNERDTreePreviewItem(winnr)
  let prev_winnr = winnr()
  call s:MyNERDTreeEditItem(a:winnr)
  exec prev_winnr."wincmd w"
endfunc

"------------------------------------------------------
func s:MyNERDTreePrintItem()
  let key = s:MyNERDTreeSelected()
  if (len(key) > s:bmk_winwidth / 2)
    echo key
  else
    echo ""
  endif
endfunc

func s:MyNERDTreePrevItem()
  normal -
  call s:MyNERDTreePrintItem()
endfunc

func s:MyNERDTreeNextItem()
  normal +
  call s:MyNERDTreePrintItem()
endfunc

"------------------------------------------------------
func vis#external#nerdtree#MyNERDTreeMap()
  nmap <buffer> h       u
  nmap <buffer> l       :call <SID>MyNERDTreePreviewItem(-2)<CR>
  nmap <buffer> j       :call <SID>MyNERDTreeNextItem()<CR>
  nmap <buffer> k       :call <SID>MyNERDTreePrevItem()<CR>

  nmap <buffer> 2       :call <SID>MyNERDTreeEditItem(2)<CR>
  nmap <buffer> 3       :call <SID>MyNERDTreeEditItem(3)<CR>
  nmap <buffer> 4       :call <SID>MyNERDTreeEditItem(4)<CR>
  nmap <buffer> 5       :call <SID>MyNERDTreeEditItem(5)<CR>
  nmap <buffer> 6       :call <SID>MyNERDTreeEditItem(6)<CR>
  nmap <buffer> 7       :call <SID>MyNERDTreeEditItem(7)<CR>
  nmap <buffer> 8       :call <SID>MyNERDTreeEditItem(8)<CR>
  nmap <buffer> 9       :call <SID>MyNERDTreeEditItem(9)<CR>

  nmap <buffer> B       :Bookmark<CR>
  nmap <buffer> E       :EditBookmarks<CR>
  "nmap <buffer> D       :echo D<CR>  "delete bookmark

  "nmap <buffer> <Space> goq
  nmap <buffer> <C-J>   <C-W>w
  nmap <buffer> <C-K>   <C-W>W
  nmap <buffer> <C-.>   C
endfunc

