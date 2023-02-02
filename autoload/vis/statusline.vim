"======================================================
" statusline
"======================================================
func vis#statusline#_is_same_dir()
  let cwd = getcwd(0, 0)
  let dir = expand("%:p:h")
  if (cwd != dir)
    return "*"
  else
    return ""
  endif
endfunc

func vis#statusline#_file_type()
  let stat = ""
  let ft = getwinvar(0, '&ft')
  let syn = getwinvar(0, '&syn')

  if ft == syn
    let stat = printf("[%s]", ft)
  else
    let stat = printf("[%s,%s]", ft, syn)
  endif

  return stat
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

func vis#statusline#_coc_info()
  let stat = ''
  if exists('*coc#status')
    let stat = coc#status()
  endif
  if stat != ''
    let stat = printf('[coc: %s]', stat)
  endif
  return stat
endfunc

func vis#statusline#_git_status()
  let stat = ''
  if exists('*FugitiveStatusline')
    let stat = substitute(FugitiveStatusline(), 'Git', ' ', '')
  endif
  return stat
endfunc

"------------------------------------------------------
func vis#statusline#win_nr()
  let stat   = "%#VisWinNrRevBold#"
  let stat ..= " %{printf('%s', winnr())} "
  let stat ..= "%#VisWinNr#"
  let stat ..= ""
  let stat ..= "%#StatusLineNC#"
  let stat ..= " "
  return stat
endfunc

func vis#statusline#file_name()
  let stat   = "%#VisFname#"
  let stat ..= "%{vis#statusline#_is_same_dir()}"
  let stat ..= "%t"
  let stat ..= "%#StatusLineNC#"
  let stat ..= " "
  return stat
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
  return "[Col %c%V,Ln %l/%L %p%%]"
endfunc

func vis#statusline#separator()
  return "%<%="
endfunc

func vis#statusline#coc_info()
  let stat = ''
  if $MY_PROMPT_TYPE >= 3
    let stat ..= '%{vis#statusline#_coc_info()}'
  endif
  return stat
endfunc

func vis#statusline#git_status()
  let stat = ''
  if $MY_PROMPT_TYPE >= 3
    let stat ..= '%#VisGitStatus#'
    let stat ..= '%{vis#statusline#_git_status()}'
    let stat ..= '%#StatusLineNC#'
  endif
  return stat
endfunc

func vis#statusline#cwd()
  let stat   = '%#VisCWD#'
  let stat ..= '%{vis#util#VisCWD()}'
  let stat ..= '%#StatusLineNC#'
  return stat
endfunc

func vis#statusline#term_label()
  let stat   = '%{vis#statusline#get_label()}'
  let stat ..= ' (bufnr:%n)'
  return stat
endfunc

"------------------------------------------------------
" statusline for buffer
"------------------------------------------------------
func vis#statusline#_setup()
  let stat   = vis#statusline#win_nr()
  let stat ..= vis#statusline#file_name()
  let stat ..= vis#statusline#file_type()
  let stat ..= vis#statusline#file_encoding()
  let stat ..= vis#statusline#indicator()
  let stat ..= vis#statusline#coc_info()
  let stat ..= vis#statusline#separator()
  let stat ..= vis#statusline#line_info()
  let stat ..= vis#statusline#git_status()
  return stat
endfunc

func vis#statusline#setup()
  set statusline=%!vis#statusline#_setup()
endfunc

"------------------------------------------------------
" statusline for sidebar
"------------------------------------------------------
func vis#statusline#_setup_side_bar()
  let stat   = vis#statusline#win_nr()
  let stat ..= "%t"
  let stat ..= vis#statusline#separator()
  let stat ..= "[%l/%L]"
  return stat
endfunc

func vis#statusline#setup_side_bar()
  if vis#sidebar#inside() == 1
    setl statusline=%!vis#statusline#_setup_side_bar()
  endif
endfunc

"------------------------------------------------------
" statusline for terminal
"------------------------------------------------------
func vis#statusline#get_label()
  if !exists("w:status_label")
    let w:status_label = "terminal"
  endif
  return w:status_label
endfunc

func vis#statusline#set_label(label)
  let w:status_label = a:label
  call vis#statusline#setup_term()
endfunc

func vis#statusline#_setup_term()
  let stat   = vis#statusline#win_nr()
  let stat ..= vis#statusline#term_label()
  let stat ..= vis#statusline#separator()
  let stat ..= vis#statusline#cwd()
  return stat
endfunc

func vis#statusline#setup_term()
  if &buftype == 'terminal'
    setl statusline=%!vis#statusline#_setup_term()
  endif
endfunc

