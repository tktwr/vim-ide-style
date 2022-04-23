"======================================================
" nerdtree
"======================================================

let s:bmk_winwidth = 30
if exists("g:bmk_winwidth")
  let s:bmk_winwidth = g:bmk_winwidth
endif

"------------------------------------------------------

func vis#external#nerdtree#VisNERDTreeToggle()
  if (&filetype == "nerdtree")
    NERDTreeToggle
  elseif (&filetype == "")
    NERDTree
  else
    vis#external#nerdtree#VisNERDTreeFind("%:p:h")
  endif
endfunc

func vis#external#nerdtree#VisNERDTreeFind(dir)
  let dir = expand(a:dir)
  call wbl#WblFind('NERD_tree', 1)
  exec "NERDTreeFind" dir
endfunc

"------------------------------------------------------
func s:VisNERDTreeSelected()
  let n = g:NERDTreeFileNode.GetSelected()
  if n != {}
    return n.path.str()
  endif
  return ""
endfunc

func s:VisNERDTreeEditItem(winnr)
  let selected = s:VisNERDTreeSelected()
  if (selected == "")
    return
  endif

  call bmk#BmkEdit(selected, a:winnr)
endfunc

func s:VisNERDTreePreviewItem(winnr)
  let prev_winnr = winnr()
  call s:VisNERDTreeEditItem(a:winnr)
  exec prev_winnr."wincmd w"
endfunc

"------------------------------------------------------
func s:VisNERDTreePrintItem()
  let key = s:VisNERDTreeSelected()
  if (len(key) > s:bmk_winwidth / 2)
    echo key
  else
    echo ""
  endif
endfunc

func s:VisNERDTreePrevItem()
  normal -
  call s:VisNERDTreePrintItem()
endfunc

func s:VisNERDTreeNextItem()
  normal +
  call s:VisNERDTreePrintItem()
endfunc

"------------------------------------------------------
func vis#external#nerdtree#VisNERDTreeMap()
  nmap <buffer> h       u
  nmap <buffer> l       :call <SID>VisNERDTreePreviewItem(-2)<CR>
  nmap <buffer> j       :call <SID>VisNERDTreeNextItem()<CR>
  nmap <buffer> k       :call <SID>VisNERDTreePrevItem()<CR>

  nmap <buffer> 2       :call <SID>VisNERDTreeEditItem(2)<CR>
  nmap <buffer> 3       :call <SID>VisNERDTreeEditItem(3)<CR>
  nmap <buffer> 4       :call <SID>VisNERDTreeEditItem(4)<CR>
  nmap <buffer> 5       :call <SID>VisNERDTreeEditItem(5)<CR>
  nmap <buffer> 6       :call <SID>VisNERDTreeEditItem(6)<CR>
  nmap <buffer> 7       :call <SID>VisNERDTreeEditItem(7)<CR>
  nmap <buffer> 8       :call <SID>VisNERDTreeEditItem(8)<CR>
  nmap <buffer> 9       :call <SID>VisNERDTreeEditItem(9)<CR>

  nmap <buffer> B       :Bookmark<CR>
  nmap <buffer> E       :EditBookmarks<CR>
  "nmap <buffer> D       :echo D<CR>  "delete bookmark

  "nmap <buffer> <Space> goq
  nmap <buffer> <C-J>   <C-W>w
  nmap <buffer> <C-K>   <C-W>W
  nmap <buffer> <C-.>   C
endfunc

