"------------------------------------------------------
" get item
"------------------------------------------------------
" bmk format
"   [title] str
"   space [-+] shortcut key    | val

" return "title"
func bmk#item#GetTitle(line)
  let mx = '^\[\(.\+\)\].*'
  let line = a:line
  let line = matchstr(line, mx)
  let item = substitute(line, mx, '\1', '')
  return item
endfunc

" return indexed item
func bmk#item#GetItem(line, idx)
  let mx = '[-+*] \(.\+\)\s*|\s*\(.\+\)\s*|\s*\(.\+\)'
  let line = a:line
  let line = matchstr(line, mx)
  let item = substitute(line, mx, '\'.a:idx, '')
  let item = bmk#util#RemoveEndSpaces(item)
  return item
endfunc

" return key
func bmk#item#GetKeyItem()
  let line = getline('.')
  return bmk#item#GetItem(line, 2)
endfunc

" return val
func bmk#item#GetValueItem()
  let line = getline('.')
  return bmk#item#GetItem(line, 3)
endfunc

func bmk#item#GetExpandedValueItem(line='')
  if a:line == ''
    let line = getline('.')
  else
    let line = a:line
  endif
  return bmk#util#expand(bmk#item#GetItem(line, 3))
endfunc

"------------------------------------------------------
" print item
"------------------------------------------------------
func bmk#item#PrintItem()
  if g:bmk_debug
    let key = bmk#item#GetKeyItem()
    let val = bmk#item#GetExpandedValueItem()
    let type = bmk#util#type(val)
    echo "key=[".key."], val=[".val."], type=[".type."]"
  else
    let key = bmk#item#GetKeyItem()
    if (len(key) > g:bmk_winwidth / 2)
      echo key
    else
      echo ""
    endif
  endif
endfunc

func bmk#item#PrevItem()
  normal -
  call bmk#item#PrintItem()
endfunc

func bmk#item#NextItem()
  normal +
  call bmk#item#PrintItem()
endfunc

"------------------------------------------------------
" action on bmk item
"------------------------------------------------------
func bmk#item#OpenItem(winnr=0, line='')
  let val = bmk#item#GetExpandedValueItem(a:line)
  if val == ""
    return
  endif

  call bmk#Open(val, a:winnr)
endfunc

func bmk#item#ViewItem(winnr=0, line='')
  let val = bmk#item#GetExpandedValueItem(a:line)
  if val == ""
    return
  endif

  call bmk#View(val, a:winnr)
endfunc

func bmk#item#EditItem(winnr=0, line='')
  let val = bmk#item#GetExpandedValueItem(a:line)
  if val == ""
    return
  endif

  call bmk#Edit(val, a:winnr)
endfunc

func bmk#item#PreviewItem(winnr=0)
  let prev_winnr = winnr()
  call bmk#item#EditItem(a:winnr)
  exec prev_winnr."wincmd w"
endfunc

"------------------------------------------------------
func bmk#item#EditWinbuf(line='')
  let lst = split(a:line)
  let bufnr = lst[0]
  exec printf("%db", bufnr)
endfunc
