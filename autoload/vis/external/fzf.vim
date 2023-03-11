"======================================================
" fzf
"======================================================
func vis#external#fzf#bmk()
  if vis#sidebar#inside()
    " Fern menu
    let source = 'bmk_dir.txt fern.txt'
    let prompt_icons = '  '
  else
    " Editor menu
    let source = 'bmk_file.txt vcmd.txt fzf.txt coc.txt ref.txt links.txt papers.txt'
    let prompt_icons = '   '
  endif

  let prompt = printf('Bmk(%s)> ', prompt_icons)

  let options  = ['--prompt', prompt]
  let options += ['--header', '[C-R:open, A-T:preview, A-N:p-next, A-P:p-prev]']
  let options += ['--bind', 'ctrl-r:execute(fzf_bmk.sh --eval-open {})']
  let options += ['--preview', 'preview_bmk.sh {}']

  let opt = {
    \ 'source'  : printf("fzf_bmk.sh --src %s", source),
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

  let source = printf('fzf_fd.sh --src --type=%s', a:type)
  let prompt = printf('Fd(%s)> ', prompt_icons)

  let options  = ['--prompt', prompt]
  let options += ['--header', '[C-D:dir, C-F:file, A-X:explorer, A-C:chrome, A-V:vscode, A-T:preview, A-N:p-next, A-P:p-prev]']
  let options += ['--bind', 'ctrl-d:reload(fzf_fd.sh --src --type=d)']
  let options += ['--bind', 'ctrl-f:reload(fzf_fd.sh --src --type=f)']
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
    let query = expand(query)
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

  let cmd = "rg --column --line-number --no-heading --color=always --smart-case -- ''" .. dirs
  let prompt = printf('Rg(%s)> ', prompt_icons)

  let options  = ['--prompt', prompt]
  let options += ['--header', '[A-A:select all, A-D:deselect all, <TAB>:select, <multi:CR>:quickfix]']
  let options += ['--query', query]

  let opt = fzf#vim#with_preview({
    \ 'options': options,
    \ 'dir': base_dir,
    \ })

  call fzf#vim#grep(cmd, 1, opt, 0)
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

