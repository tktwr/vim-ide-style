"------------------------------------------------------
" statusline
"------------------------------------------------------
func vis#statusline#TtStatuslineWinNr()
  return printf("[%s] ", winnr())
endfunc

func vis#statusline#TtStatuslineFname()
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

func vis#statusline#TtStatuslineFileType()
  let ft = getwinvar(0, '&ft')
  let syn = getwinvar(0, '&syn')

  if ft == syn
    let type = "[".ft."]"
  else
    let type = "[".ft.",".syn."]"
  endif

  return type
endfunc

func vis#statusline#TtStatuslineIndicator()
  return "%m%r%w%q"
endfunc

func vis#statusline#TtStatuslineFileEnc()
  let stat = ""
  if winwidth(0) >= 60
    let fenc = &fenc != '' ? &fenc : &enc
    let ff = &ff
    let stat = printf("[%s,%s]", fenc, ff)
  endif
  return stat
endfunc

func vis#statusline#TtStatuslineLineInfo()
  let stat = ""
  if winwidth(0) >= 60
    let stat = "[%c%V,%l/%L,%p%%]"
  endif
  return stat
endfunc

func vis#statusline#TtStatuslineSeparator()
  return "%<%="
endfunc

"------------------------------------------------------
" statusline for buffer
"------------------------------------------------------
func vis#statusline#MyStatusline()
  let stat = "%{vis#statusline#TtStatuslineWinNr()}"
  let stat.= vis#statusline#TtStatuslineFname()
  let stat.= "%{vis#statusline#TtStatuslineFileType()}"
  let stat.= vis#statusline#TtStatuslineIndicator()
  let stat.= "%{vis#statusline#TtStatuslineFileEnc()}"
  let stat.= vis#statusline#TtStatuslineSeparator()
  let stat.= vis#statusline#TtStatuslineLineInfo()

  if $MY_PROMPT_TYPE >= 3
    let stat.= "%6*%{FugitiveStatusline()}%0*"
  endif
  return stat
endfunc

"------------------------------------------------------
" statusline for sidebar
"------------------------------------------------------
func vis#statusline#TtStatuslineForSideBar()
  let stat = "%{vis#statusline#TtStatuslineWinNr()}"
  let stat.= "%t "
  let stat.= "%{vis#statusline#TtStatuslineFileType()}"
  let stat.= vis#statusline#TtStatuslineIndicator()
  let stat.= vis#statusline#TtStatuslineSeparator()
  let stat.= "[%c,%l]"
  return stat
endfunc

func vis#statusline#TtSetStatuslineForSideBar()
  setl statusline=%!vis#statusline#TtStatuslineForSideBar()
endfunc

"------------------------------------------------------
" statusline for terminal
"------------------------------------------------------
func vis#statusline#MyStatuslineForTerm()
  let stat = "%{vis#statusline#TtStatuslineWinNr()}"
  let stat.= "terminal:%n"
  let stat.= vis#statusline#TtStatuslineSeparator()
  let stat.= "%{vis#util#MyCWD()}"
  return stat
endfunc

func vis#statusline#MySetStatuslineForTerm()
  setl statusline=%!vis#statusline#MyStatuslineForTerm()
endfunc

