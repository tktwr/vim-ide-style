"======================================================
" tabline
"======================================================
func vis#tabline#MyTabLine()
  let s = ''

  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    " the label is made by vis#tabline#MyTabLine_GetLabel()
    let s .= ' %{vis#tabline#MyTabLine_GetLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  let s .= "%="
  if $MY_PROMPT_TYPE >= 3
    let s .= "\ [coc:%{coc#status()}]"
  endif
  let s .= "\ %6*%{vis#util#MyCWD()}%0*"
  let s .= "\ %6*%{vis#tabline#MyTabLine_GetInfo()}%0*"

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= "\ %#TabLine#%999X[x]"
  endif

  return s
endfunc

"------------------------------------------------------
" get tab label
"------------------------------------------------------
func vis#tabline#MyTabLine_GetLabel(nr)
  let tab_labels = keys(g:my_tab_labels)
  let r = match(tab_labels, a:nr-1)
  if r != -1
    let label = g:my_tab_labels[a:nr-1]
  else
    let label = getcwd(-1, a:nr)
    let label = vis#util#MyUnexpand(label)
  endif

  return "[".a:nr."] ".label
endfunc

func vis#tabline#MyTabLine_GetInfo()
  return g:my_tab_info
endfunc

"------------------------------------------------------
" set tab label
"------------------------------------------------------
func vis#tabline#MyTabLine_SetLabel(label)
  let nr = tabpagenr()
  let g:my_tab_labels[nr-1] = a:label
  set tabline=%!vis#tabline#MyTabLine()
endfunc

func vis#tabline#MyTabLine_SetInfo(label)
  let g:my_tab_info = a:label
  set tabline=%!vis#tabline#MyTabLine()
endfunc

