"======================================================
" fzf
"======================================================
"------------------------------------------------------
" fzf#bmk
"------------------------------------------------------
func vis#external#fzf#bmk()
  let is_git_dir = FugitiveIsGitDir() ? 1 : 0

  " --- source ---
  let query = ''
  if vis#sidebar#inside()
    " Fern menu
    let bmk_files = 'bmk_dir.txt fern.txt bmk_dir_opt.txt'
  elseif (&filetype == 'fugitive')
    let bmk_files = 'vcmd_context.txt'
    let query = 'fugitive: '
  elseif (&filetype == 'git')
    let bmk_files = 'vcmd_context.txt'
    let query = 'gv.git: '
  elseif (&filetype == 'dirdiff')
    let bmk_files = 'vcmd_context.txt'
    let query = 'Dirdiff: '
  elseif &diff == 1
    let bmk_files = 'vcmd_context.txt'
    let query = 'Diff: '
  else
    " Editor menu
    let bmk_files = 'bmk_file.txt vcmd.txt fzf.txt coc.txt bmk_file_opt.txt ref.txt links.txt papers.txt'
  endif

  let source = printf('bmk.sh %s', bmk_files)

  " --- prompt ---
  let prompt = is_git_dir ? 'Bmk( )> ' : 'Bmk> '

  " --- options ---
  let options  = ['--prompt', prompt]
  let options += ['--ansi']
  let options += ['--info', 'inline-right']
  let options += ['--header', '[A-O:open|A-T:preview|A-N:p-next|A-P:p-prev]']
  let options += ['--bind', 'alt-o:execute(open_bmk.sh {})']
  let options += ['--preview', 'preview_bmk.sh {}']
  let options += ['--query', query]

  let opt = {
    \ 'source'  : source,
    \ 'options' : options,
    \ 'sink'    : 'BmkEditItem',
    \ }

  call fzf#run(fzf#wrap(opt))
endfunc

"------------------------------------------------------
" fzf#fd
"------------------------------------------------------
func vis#external#fzf#fd(type, sink)
  let is_git_dir = FugitiveIsGitDir() ? 1 : 0

  " --- source ---
  let fd_prefix = 'fdfind --color=always'
  let source = fd_prefix
  if a:type != ''
    let source = printf('%s --type=%s', fd_prefix, a:type)
  endif

  " --- prompt ---
  let prompt = is_git_dir ? 'Fd( )> ' : 'Fd> '

  " --- sink ---
  let sink = a:sink
  if vis#sidebar#inside() && (&filetype == 'fern')
    let sink = 'BmkEditDir'
  endif

  " --- base_dir ---
  let base_dir = is_git_dir ? vis#util#git_root_dir() : '.'

  " --- options ---
  let options  = ['--prompt', prompt]
  let options += ['--ansi']
  let options += ['--info', 'inline-right']
  let options += ['--header', '[A-A:all|A-D:dir|A-F:file|A-X:explorer|A-C:chrome|A-V:vscode|A-T:preview|A-N:p-next|A-P:p-prev]']
  let options += ['--bind', printf('alt-a:reload(%s)', fd_prefix)]
  let options += ['--bind', printf('alt-d:reload(%s --type=d)', fd_prefix)]
  let options += ['--bind', printf('alt-f:reload(%s --type=f)', fd_prefix)]
  let options += ['--bind', 'alt-x:execute(te.sh {})']
  let options += ['--bind', 'alt-c:execute(chrome.sh {})']
  let options += ['--bind', 'alt-v:execute(vscode.sh {})']
  let options += ['--preview', 'preview.sh {}']

  let opt = {
    \ 'source'  : source,
    \ 'options' : options,
    \ 'sink'    : sink,
    \ 'dir'     : base_dir,
    \ }

  call fzf#run(fzf#wrap(opt))
endfunc

"------------------------------------------------------
" fzf#rg
"------------------------------------------------------
func vis#external#fzf#rg(query='', dirs=[])
  let is_git_dir = FugitiveIsGitDir() ? 1 : 0

  " --- source ---
  let query = a:query
  if (match(query, '<cfile>') == 0)
    let query = printf('-w %s', expand(query))
  endif

  let dirs = ""
  for i in a:dirs
    let dirs ..= printf(" '%s'", expand(i))
  endfor

  let rg_prefix = "rg.sh"
  let source = printf("%s %s %s", rg_prefix, query, dirs)
  let source_change = printf('change:reload:sleep 0.1; %s {q} %s || true', rg_prefix, dirs)

  " --- prompt ---
  let prompt = is_git_dir ? 'Rg( )> ' : 'Rg> '

  " --- base_dir ---
  let base_dir = is_git_dir ? vis#util#git_root_dir() : '.'

  exec "tcd" base_dir

  " --- options ---
  let options  = ['--prompt', prompt]
  let options += ['--ansi']
  let options += ['--info', 'inline-right']
  let options += ['--header', '[-w:word|-s:case sensitive|A-A:select all|A-D:deselect all|<TAB>:select|<multi:CR>:quickfix]']
  let options += ['--disabled']
  let options += ['--bind', source_change]
  let options += ['--query', query]

  let opt = fzf#vim#with_preview({
    \ 'options': options,
    \ 'dir': base_dir,
    \ })

  call fzf#vim#grep(source, 1, opt, 0)
endfunc

"------------------------------------------------------
" fzf#tags
"------------------------------------------------------
func vis#external#fzf#tags(query='')
  let query = a:query
  if (match(query, '<cfile>') == 0)
    let query = expand(query)
  endif

  let opt = fzf#vim#with_preview({
    \ "placeholder": "--tag {2}:{-1}:{3..}"
    \ })
  call fzf#vim#tags(query, opt, 0)
endfunc

