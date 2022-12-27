"======================================================
" tabline
"======================================================
func vis#tabline#_setup()
  let tabline_all = ''

  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let color = '%#TabLineSel#'
    else
      let color = '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let tag = printf('%%%dT', i + 1)
    let label = printf('%%{vis#tabline#get_label(%d)}', i + 1)
    let tabline_all .= printf('%s%s %s ', tag, color, label)
    let tabline_all .= '%#TabLineFill# '
  endfor

  " reset tab page nr
  let tabline_all .= '%T%='

  if $MY_PROMPT_TYPE >= 3
    let tabline_all .= ' [coc:%{coc#status()}]'
  endif
  let tabline_all .= ' %#VisCWD#%{vis#util#VisCWD()}%#TabLineFill#'
  let tabline_all .= ' %#VisInfo#%{vis#tabline#get_info()}%#TabLineFill#'

  return tabline_all
endfunc

func vis#tabline#setup()
  set tabline=%!vis#tabline#_setup()
endfunc

"------------------------------------------------------
" label
"------------------------------------------------------
func vis#tabline#get_label(nr)
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

func vis#tabline#set_label(label)
  let nr = tabpagenr()
  let g:vis#vis_tab_labels[nr-1] = a:label
  call vis#tabline#setup()
endfunc

"------------------------------------------------------
" info
"------------------------------------------------------
func vis#tabline#get_info()
  return g:vis#vis_tab_info
endfunc

func vis#tabline#set_info(label)
  let g:vis#vis_tab_info = a:label
  call vis#tabline#setup()
endfunc

