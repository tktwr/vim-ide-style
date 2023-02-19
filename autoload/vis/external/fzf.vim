"======================================================
" fzf
"======================================================
func vis#external#fzf#bmk()
  if vis#sidebar#inside()
    " Fern menu
    let source = 'bmk_dir.txt fern.txt'
    let prompt = '     '
  else
    " Editor menu
    let source = 'bmk_file.txt vcmd.txt fzf.txt coc.txt ref.txt links.txt papers.txt'
    let prompt = '      '
  endif

  let options  = ['--prompt', prompt]
  let options += ['--preview', 'preview_bmk.sh {}']
  let options += ['--header', '[C-R:open, C-T:preview]']
  let options += ['--bind', 'ctrl-r:execute(fzf_bmk.sh --eval-open {})']
  let options += ['--bind', 'ctrl-t:toggle-preview']

  let opt = {
    \ 'source'  : printf("fzf_bmk.sh --src %s", source),
    \ 'options' : options,
    \ 'sink'    : 'BmkEditItem',
    \ }

  call fzf#run(fzf#wrap(opt))
endfunc

func vis#external#fzf#fd(type, sink)
  let prompt = '    '
  let dir = '.'
  if FugitiveIsGitDir()
    let prompt = ' ' . prompt
    let dir = systemlist('git rev-parse --show-toplevel')[0]
  endif

  let source = printf('fzf_fd.sh --src --type=%s', a:type)

  let options  = ['--prompt', prompt]
  let options += ['--preview', 'preview.sh {}']
  let options += ['--header', '[C-D:dir, C-F:file, C-T:preview, A-X:explorer, A-C:chrome, A-V:vscode]']
  let options += ['--bind', 'ctrl-d:reload(fzf_fd.sh --src --type=d)']
  let options += ['--bind', 'ctrl-f:reload(fzf_fd.sh --src --type=f)']
  let options += ['--bind', 'ctrl-t:toggle-preview']
  let options += ['--bind', 'alt-x:execute(te.sh {})']
  let options += ['--bind', 'alt-c:execute(chrome.sh {})']
  let options += ['--bind', 'alt-v:execute(vscode.sh {})']

  let opt = {
    \ 'source'  : source,
    \ 'options' : options,
    \ 'sink'    : a:sink,
    \ 'dir'     : dir,
    \ }

  call fzf#run(fzf#wrap(opt))
endfunc

func vis#external#fzf#rg()
  let prompt = '   '
  let dir = '.'
  if FugitiveIsGitDir()
    let prompt = ' ' . prompt
    let dir = systemlist('git rev-parse --show-toplevel')[0]
  endif

  exec "tcd" dir

  let cmd = 'rg --column --line-number --no-heading --color=always --smart-case -- ""'

  let options  = ['--prompt', prompt]
  let options += ['--header', '[<TAB>:select, C-T:all, C-Q:quickfix]']
  let options += ['--bind', 'ctrl-t:toggle-all']

  let opt = fzf#vim#with_preview({
    \ 'options': options,
    \ 'dir': dir,
    \ })

  call fzf#vim#grep(cmd, 1, opt, 0)
endfunc

