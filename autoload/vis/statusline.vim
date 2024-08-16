"======================================================
" statusline
"======================================================
func vis#statusline#_is_same_dir()
  let cwd = getcwd(winnr(), 0)
  let dir = fnamemodify(bufname(bufnr()), ":p:h")
  return cwd == dir
endfunc

func vis#statusline#_file_name()
  let file = fnamemodify(bufname(bufnr()), ":p")
  let file = vis#util#VisUnexpand(file)
  return file
endfunc

func vis#statusline#_dir_name()
  let dir = fnamemodify(bufname(bufnr()), ":p:h")
  let fs = vis#util#file_system(dir)

  if !vis#statusline#_is_same_dir()
    let is_same_dir = "[*]"
  else
    let is_same_dir = ""
  endif

  let dir = vis#util#VisUnexpand(dir)
  return printf("[ %s][%s]%s", dir, fs, is_same_dir)
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
func vis#statusline#win_nr_col_rev(sel=v:false)
  return a:sel ? "%#VisSelWinNrRevBold#" : "%#VisWinNrRevBold#"
endfunc

func vis#statusline#win_nr_col(sel=v:false)
  return a:sel ? "%#VisSelWinNr#" : "%#VisWinNr#"
endfunc

func vis#statusline#win_nr(sel=v:false)
  let stat   = vis#statusline#win_nr_col_rev(a:sel)
  let stat ..= " %{printf('%s', winnr())} "
  let stat ..= vis#statusline#win_nr_col(a:sel)
  let stat ..= ""
  let stat ..= "%#StatusLineNC#"
  let stat ..= " "
  return stat
endfunc

func vis#statusline#file_name()
  let stat   = "%#VisFname#"
  let stat ..= "%t"
  let stat ..= "%#StatusLineNC#"
  let stat ..= " "
  return stat
endfunc

func vis#statusline#dir_name()
  let stat   = "%#VisYellowRevBold#"
  let stat ..= "%{vis#statusline#_dir_name()}"
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
  return "[C:%c%V,L:%l/%L %p%%]"
endfunc

func vis#statusline#separator()
  return " %<%="
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
func vis#statusline#_setup(sel=v:false)
  let stat   = vis#statusline#win_nr(a:sel)
  let stat ..= vis#statusline#file_name()
  let stat ..= vis#statusline#file_type()
  let stat ..= vis#statusline#file_encoding()
  let stat ..= vis#statusline#indicator()
  let stat ..= vis#statusline#coc_info()
  let stat ..= vis#statusline#separator()
  let stat ..= vis#statusline#dir_name()
  let stat ..= vis#statusline#line_info()
  let stat ..= vis#statusline#git_status()
  return stat
endfunc

"------------------------------------------------------
" statusline for sidebar
"------------------------------------------------------
func vis#statusline#_setup_side_bar(sel=v:false)
  let stat   = vis#statusline#win_nr(a:sel)
  let stat ..= "%t"
  let stat ..= vis#statusline#separator()
  let stat ..= "[%l/%L]"
  return stat
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
  call vis#statusline#setup_local_term()
endfunc

func vis#statusline#_setup_term(sel=v:false)
  let stat   = vis#statusline#win_nr(a:sel)
  let stat ..= vis#statusline#term_label()
  let stat ..= vis#statusline#separator()
  let stat ..= vis#statusline#cwd()
  return stat
endfunc

"------------------------------------------------------
" setup global
"------------------------------------------------------
func vis#statusline#setup()
  set statusline=%!vis#statusline#_setup()
endfunc

"------------------------------------------------------
" setup local
"------------------------------------------------------
func vis#statusline#setup_local()
  if &buftype == 'terminal'
    setl statusline=%!vis#statusline#_setup_term(v:true)
  elseif vis#sidebar#inside() == 1
    setl statusline=%!vis#statusline#_setup_side_bar(v:true)
  else
    setl statusline=%!vis#statusline#_setup(v:true)
  endif
endfunc

func vis#statusline#setup_local_nc()
  if &buftype == 'terminal'
    setl statusline=%!vis#statusline#_setup_term(v:false)
  elseif vis#sidebar#inside() == 1
    setl statusline=%!vis#statusline#_setup_side_bar(v:false)
  else
    setl statusline=%!vis#statusline#_setup(v:false)
  endif
endfunc

func vis#statusline#setup_local_term()
  call vis#statusline#setup_local()
endfunc

