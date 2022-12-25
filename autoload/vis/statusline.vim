"------------------------------------------------------
" statusline
"------------------------------------------------------
func vis#statusline#_file_type()
  let ft = getwinvar(0, '&ft')
  let syn = getwinvar(0, '&syn')

  if ft == syn
    let type = printf("[%s]", ft)
  else
    let type = printf("[%s,%s]", ft, syn)
  endif

  return type
endfunc

func vis#statusline#_file_encoding()
  let stat = ""
  if winwidth(0) >= 60
    let fenc = &fenc != '' ? &fenc : &enc
    let ff = &ff
    let stat = printf("[%s,%s]", fenc, ff)
  endif
  return stat
endfunc

"------------------------------------------------------
func vis#statusline#win_nr()
  let stat = "%#VisWinNrRevBold#"
  let stat.= " %{printf('%s', winnr())} "
  let stat.= "%#VisWinNr#"
  let stat.= ""
  let stat.= "%#StatusLineNC#"
  let stat.= " "
  return stat
endfunc

func vis#statusline#file_name()
  let cwd = getcwd()
  let dir = expand("%:p:h")
  let color = "%#VisFname#"
  if (cwd != dir)
    let color = "%#VisFname2#"
  endif
  return color."%t"."%#StatusLineNC# "
endfunc

func vis#statusline#file_type()
  return "%{vis#statusline#_file_type()}"
endfunc

func vis#statusline#file_encoding()
  return "%{vis#statusline#_file_encoding()}"
endfunc

func vis#statusline#indicator()
  return "%m%r%w%q"
endfunc

func vis#statusline#line_info()
  let stat = ""
  if winwidth(0) >= 60
    let stat = "[%c%V,%l/%L,%p%%]"
  endif
  return stat
endfunc

func vis#statusline#separator()
  return "%<%="
endfunc

func vis#statusline#git_status()
  let s = "%#VisGitStatus#"
  let s.= "%{FugitiveStatusline()}"
  let s.= "%#StatusLineNC#"
  return s
endfunc

func vis#statusline#cwd()
  let s = "%#VisCWD#"
  let s.= "%{vis#util#VisCWD()}"
  let s.= "%#StatusLineNC#"
  return s
endfunc

func vis#statusline#term_label()
  return "%{vis#statusline#VisStatuslineForTerm_GetLabel()} (bufnr:%n)"
endfunc

"------------------------------------------------------
" statusline for buffer
"------------------------------------------------------
func vis#statusline#VisStatusline()
  let stat = vis#statusline#win_nr()
  let stat.= vis#statusline#file_name()
  let stat.= vis#statusline#file_type()
  let stat.= vis#statusline#file_encoding()
  let stat.= vis#statusline#indicator()
  let stat.= vis#statusline#separator()
  let stat.= vis#statusline#line_info()
  if $MY_PROMPT_TYPE >= 3
    let stat.= vis#statusline#git_status()
  endif

  return stat
endfunc

"------------------------------------------------------
" statusline for sidebar
"------------------------------------------------------
func vis#statusline#VisStatuslineForSideBar()
  let stat = vis#statusline#win_nr()
  let stat.= "%t "
  "let stat.= vis#statusline#file_type()
  "let stat.= vis#statusline#indicator()
  let stat.= vis#statusline#separator()
  let stat.= "[%l/%L]"
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
  let stat = vis#statusline#win_nr()
  let stat.= vis#statusline#term_label()
  let stat.= vis#statusline#separator()
  let stat.= vis#statusline#cwd()
  return stat
endfunc

func vis#statusline#VisSetStatuslineForTerm()
  setl statusline=%!vis#statusline#VisStatuslineForTerm()
endfunc

