"======================================================
" tabline
"======================================================
func vis#tabline#VisTabLine()
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

    " the label is made by vis#tabline#VisTabLine_GetLabel()
    let s .= ' %{vis#tabline#VisTabLine_GetLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  let s .= "%="
  if $MY_PROMPT_TYPE >= 3
    let s .= "\ [coc:%{coc#status()}]"
  endif
  let s .= "\ %6*%{vis#util#VisCWD()}%0*"
  let s .= "\ %6*%{vis#tabline#VisTabLine_GetInfo()}%0*"

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= "\ %#TabLine#%999X[x]"
  endif

  return s
endfunc

"------------------------------------------------------
" get tab label
"------------------------------------------------------
func vis#tabline#VisTabLine_GetLabel(nr)
  let tab_labels = keys(g:vis#vis_tab_labels)
  let r = match(tab_labels, a:nr-1)
  if r != -1
    let label = g:vis#vis_tab_labels[a:nr-1]
  else
    let label = getcwd(-1, a:nr)
    let label = vis#util#VisUnexpand(label)
  endif

  return "[".a:nr."] ".label
endfunc

func vis#tabline#VisTabLine_GetInfo()
  return g:vis#vis_tab_info
endfunc

"------------------------------------------------------
" set tab label
"------------------------------------------------------
func vis#tabline#VisTabLine_SetLabel(label)
  let nr = tabpagenr()
  let g:vis#vis_tab_labels[nr-1] = a:label
  set tabline=%!vis#tabline#VisTabLine()
endfunc

func vis#tabline#VisTabLine_SetInfo(label)
  let g:vis#vis_tab_info = a:label
  set tabline=%!vis#tabline#VisTabLine()
endfunc

