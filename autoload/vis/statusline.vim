"------------------------------------------------------
" statusline
"------------------------------------------------------
func vis#statusline#VisStatuslineWinNr()
  return printf("[%s] ", winnr())
endfunc

func vis#statusline#VisStatuslineFname()
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

func vis#statusline#VisStatuslineFileType()
  let ft = getwinvar(0, '&ft')
  let syn = getwinvar(0, '&syn')

  if ft == syn
    let type = "[".ft."]"
  else
    let type = "[".ft.",".syn."]"
  endif

  return type
endfunc

func vis#statusline#VisStatuslineIndicator()
  return "%m%r%w%q"
endfunc

func vis#statusline#VisStatuslineFileEnc()
  let stat = ""
  if winwidth(0) >= 60
    let fenc = &fenc != '' ? &fenc : &enc
    let ff = &ff
    let stat = printf("[%s,%s]", fenc, ff)
  endif
  return stat
endfunc

func vis#statusline#VisStatuslineLineInfo()
  let stat = ""
  if winwidth(0) >= 60
    let stat = "[%c%V,%l/%L,%p%%]"
  endif
  return stat
endfunc

func vis#statusline#VisStatuslineSeparator()
  return "%<%="
endfunc

"------------------------------------------------------
" statusline for buffer
"------------------------------------------------------
func vis#statusline#VisStatusline()
  let stat = "%{vis#statusline#VisStatuslineWinNr()}"
  let stat.= vis#statusline#VisStatuslineFname()
  let stat.= "%{vis#statusline#VisStatuslineFileType()}"
  let stat.= vis#statusline#VisStatuslineIndicator()
  let stat.= "%{vis#statusline#VisStatuslineFileEnc()}"
  let stat.= vis#statusline#VisStatuslineSeparator()
  let stat.= vis#statusline#VisStatuslineLineInfo()

  if $MY_PROMPT_TYPE >= 3
    let stat.= "%6*%{FugitiveStatusline()}%0*"
  endif
  return stat
endfunc

"------------------------------------------------------
" statusline for sidebar
"------------------------------------------------------
func vis#statusline#VisStatuslineForSideBar()
  let stat = "%{vis#statusline#VisStatuslineWinNr()}"
  let stat.= "%t "
  let stat.= "%{vis#statusline#VisStatuslineFileType()}"
  let stat.= vis#statusline#VisStatuslineIndicator()
  let stat.= vis#statusline#VisStatuslineSeparator()
  let stat.= "[%c,%l]"
  return stat
endfunc

func vis#statusline#VisSetStatuslineForSideBar()
  setl statusline=%!vis#statusline#VisStatuslineForSideBar()
endfunc

"------------------------------------------------------
" statusline for terminal
"------------------------------------------------------
func vis#statusline#VisStatuslineForTerm()
  let stat = "%{vis#statusline#VisStatuslineWinNr()}"
  let stat.= "terminal:%n"
  let stat.= vis#statusline#VisStatuslineSeparator()
  let stat.= "%{vis#util#VisCWD()}"
  return stat
endfunc

func vis#statusline#VisSetStatuslineForTerm()
  setl statusline=%!vis#statusline#VisStatuslineForTerm()
endfunc

