"======================================================
" fzf
"======================================================
func vis#external#fzf#bmk()
  let query = ''
  let prompt_icons = ''

  if vis#sidebar#inside()
    " Fern menu
    let bmk_files = 'bmk_dir.txt fern.txt'
    let prompt_icons = '  '
  elseif (&filetype == 'fugitive')
    let bmk_files = 'vcmd.txt'
    let query = 'fugitive: '
  elseif (&filetype == 'git')
    let bmk_files = 'vcmd.txt'
    let query = 'gv.git: '
  elseif (&filetype == 'dirdiff')
    let bmk_files = 'vcmd.txt'
    let query = 'dirdiff: '
  elseif &diff == 1
    let bmk_files = 'vcmd.txt'
    let query = 'diff: '
  else
    " Editor menu
    let bmk_files = 'bmk_file.txt vcmd.txt fzf.txt coc.txt ref.txt links.txt papers.txt'
    let prompt_icons = '   '
  endif

  let source = printf('bmk.sh %s', bmk_files)
  let prompt = printf('Bmk(%s)> ', prompt_icons)

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

func vis#external#fzf#fd(type, sink)
  let prompt_icons = '  '
  let base_dir = '.'

  if FugitiveIsGitDir()
    let prompt_icons = ' ' . prompt_icons
    let base_dir = vis#util#git_root_dir()
  endif

  let fd_prefix = 'fdfind --color=always'
  if a:type == ''
    let source = fd_prefix
  else
    let source = printf('%s --type=%s', fd_prefix, a:type)
  endif
  let prompt = printf('Fd(%s)> ', prompt_icons)

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
    \ 'sink'    : a:sink,
    \ 'dir'     : base_dir,
    \ }

  call fzf#run(fzf#wrap(opt))
endfunc

func vis#external#fzf#rg(query='', dirs=[])
  let query = a:query
  if (match(query, '<cfile>') == 0)
    let query = printf('-w %s', expand(query))
  endif

  let dirs = ""
  for i in a:dirs
    let dirs ..= printf(" '%s'", expand(i))
  endfor

  let prompt_icons = ' '
  let base_dir = '.'

  if FugitiveIsGitDir()
    let prompt_icons = ' ' . prompt_icons
    let base_dir = vis#util#git_root_dir()
  endif

  exec "tcd" base_dir

  let rg_prefix = "rg.sh"
  let source = printf("%s %s %s", rg_prefix, query, dirs)
  let source_change = printf('change:reload:sleep 0.1; %s {q} %s || true', rg_prefix, dirs)
  let prompt = printf('Rg(%s)> ', prompt_icons)

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

