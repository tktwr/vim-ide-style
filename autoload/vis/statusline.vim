"------------------------------------------------------
" statusline
"------------------------------------------------------
func vis#statusline#VisStatusline_WinNr()
  return printf("[%s] ", winnr())
endfunc

func vis#statusline#VisStatusline_Fname()
  let cwd = getcwd()
  let dir = expand("%:p:h")
  let color = ""
  if (cwd != dir)
    let color = "%3*"
  else
    let color = "%6*"
  endif
  "return color."%f"."%0* "
  return color."%t"."%0* "
endfunc

func vis#statusline#VisStatusline_FileType()
  let ft = getwinvar(0, '&ft')
  let syn = getwinvar(0, '&syn')

  if ft == syn
    let type = "[".ft."]"
  else
    let type = "[".ft.",".syn."]"
  endif

  return type
endfunc

func vis#statusline#VisStatusline_Indicator()
  return "%m%r%w%q"
endfunc

func vis#statusline#VisStatusline_FileEnc()
  let stat = ""
  if winwidth(0) >= 60
    let fenc = &fenc != '' ? &fenc : &enc
    let ff = &ff
    let stat = printf("[%s,%s]", fenc, ff)
  endif
  return stat
endfunc

func vis#statusline#VisStatusline_LineInfo()
  let stat = ""
  if winwidth(0) >= 60
    let stat = "[%c%V,%l/%L,%p%%]"
  endif
  return stat
endfunc

func vis#statusline#VisStatusline_Separator()
  return "%<%="
endfunc

"------------------------------------------------------
" statusline for buffer
"------------------------------------------------------
func vis#statusline#VisStatusline()
  let stat = "%{vis#statusline#VisStatusline_WinNr()}"
  let stat.= vis#statusline#VisStatusline_Fname()
  let stat.= "%{vis#statusline#VisStatusline_FileType()}"
  let stat.= vis#statusline#VisStatusline_Indicator()
  let stat.= "%{vis#statusline#VisStatusline_FileEnc()}"
  let stat.= vis#statusline#VisStatusline_Separator()
  let stat.= vis#statusline#VisStatusline_LineInfo()

  if $MY_PROMPT_TYPE >= 3
    let stat.= "%6*%{FugitiveStatusline()}%0*"
  endif
  return stat
endfunc

"------------------------------------------------------
" statusline for sidebar
"------------------------------------------------------
func vis#statusline#VisStatuslineForSideBar()
  let stat = "%{vis#statusline#VisStatusline_WinNr()}"
  let stat.= "%t "
  let stat.= "%{vis#statusline#VisStatusline_FileType()}"
  let stat.= vis#statusline#VisStatusline_Indicator()
  let stat.= vis#statusline#VisStatusline_Separator()
  let stat.= "[%c,%l]"
  return stat
endfunc

func vis#statusline#VisSetStatuslineForSideBar()
  setl statusline=%!vis#statusline#VisStatuslineForSideBar()
endfunc

"------------------------------------------------------
" statusline for terminal
"------------------------------------------------------
func vis#statusline#VisStatuslineForTerm_GetLabel()
  if !exists("w:status_label")
    let w:status_label = "terminal"
  endif
  return w:status_label
endfunc

func vis#statusline#VisStatuslineForTerm_SetLabel(label)
  let w:status_label = a:label
  call vis#statusline#VisSetStatuslineForTerm()
endfunc

func vis#statusline#VisStatuslineForTerm()
  let stat = "%{vis#statusline#VisStatusline_WinNr()}"
  let stat.= "%{vis#statusline#VisStatuslineForTerm_GetLabel()} (bufnr:%n)"
  let stat.= vis#statusline#VisStatusline_Separator()
  let stat.= "%{vis#util#VisCWD()}"
  return stat
endfunc

func vis#statusline#VisSetStatuslineForTerm()
  setl statusline=%!vis#statusline#VisStatuslineForTerm()
endfunc

