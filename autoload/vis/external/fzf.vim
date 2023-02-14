"======================================================
" fzf
"======================================================
func vis#external#fzf#dirs()
  let prompt = '   '
  let dir = '.'
  if FugitiveIsGitDir()
    let prompt = ' ' . prompt
    let dir = systemlist('git rev-parse --show-toplevel')[0]
  endif
  let opt = {
    \ 'source'  : 'fzf_fd.sh --src --type=d',
    \ 'options' : printf("--prompt '%s' --preview 'preview.sh {}'", prompt),
    \ 'sink'    : 'BmkEditDir',
    \ 'dir'     : dir,
    \ }
  call fzf#run(fzf#wrap(opt))
endfunc

func vis#external#fzf#files()
  let prompt = '   '
  let dir = '.'
  if FugitiveIsGitDir()
    let prompt = ' ' . prompt
    let dir = systemlist('git rev-parse --show-toplevel')[0]
  endif
  let opt = {
    \ 'source'  : 'fzf_fd.sh --src --type=f',
    \ 'options' : printf("--prompt '%s' --preview 'preview.sh {}'", prompt),
    \ 'sink'    : 'BmkEditFile',
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
  let opt = fzf#vim#with_preview()
  let opt['dir'] = dir
  let opt['options'] += ['--prompt', prompt]
  let cmd = 'rg --column --line-number --no-heading --color=always --smart-case -- ""'
  call fzf#vim#grep(cmd, 1, opt, 0)
endfunc

func vis#external#fzf#bmk()
  if vis#sidebar#inside()
    " Fern menu
    let source = 'bmk_dir.txt fern.txt'
    let prompt = '     '
  elseif &buftype == 'terminal'
    " Terminal menu
    let source = 'bmk_dir.txt tcmd.txt tcmd_git.txt tcmd_sys.txt'
    let prompt = '     '
  else
    " Editor menu
    let source = 'bmk_file.txt vcmd.txt fzf.txt coc.txt ref.txt links.txt papers.txt'
    let prompt = '      '
  endif
  let opt = {
    \ 'source'  : printf("fzf_bmk.sh --src %s", source),
    \ 'options' : printf("--prompt '%s' --preview 'preview_bmk.sh {}'", prompt),
    \ 'sink'    : 'BmkEditItem',
    \ }
  call fzf#run(fzf#wrap(opt))
endfunc

