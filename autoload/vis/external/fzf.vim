"======================================================
" fzf
"======================================================
func vis#external#fzf#dirs()
  if FugitiveIsGitDir()
    let opt = {
      \ 'source'  : 'git-ls-dirs.sh',
      \ 'options' : "--prompt '    '",
      \ 'sink'    : 'BmkEditDir',
      \ 'dir'     : systemlist('git rev-parse --show-toplevel')[0],
      \ }
  else
    let opt = {
      \ 'source'  : 'fdfind --type d --strip-cwd-prefix',
      \ 'options' : "--prompt '   '",
      \ 'sink'    : 'BmkEditDir',
      \ }
  endif
  call fzf#run(fzf#wrap(opt))
endfunc

func vis#external#fzf#files()
  if FugitiveIsGitDir()
    let opt = {
      \ 'source'  : 'git ls-files',
      \ 'options' : "--prompt '    ' --preview 'preview.sh {}'",
      \ 'sink'    : 'edit',
      \ 'dir'     : systemlist('git rev-parse --show-toplevel')[0],
      \ }
  else
    let opt = {
      \ 'source'  : 'fdfind --type f --strip-cwd-prefix',
      \ 'options' : "--prompt '   ' --preview 'preview.sh {}'",
      \ 'sink'    : 'edit',
      \ }
  endif
  call fzf#run(fzf#wrap(opt))
endfunc

func vis#external#fzf#files2()
  if FugitiveIsGitDir()
    FzfGFiles
  else
    FzfFiles
  endif
endfunc

func vis#external#fzf#bmk()
  if vis#sidebar#inside()
    " Fern menu
    let opt = {
      \ 'source'  : 'fzf_bmk.sh --src bmk_dir.txt fern.txt',
      \ 'options' : "--prompt '     '",
      \ 'sink'    : 'BmkEditItem',
      \ }
  elseif &buftype == 'terminal'
    " Terminal menu
    let opt = {
      \ 'source'  : 'fzf_bmk.sh --src bmk_dir.txt tcmd.txt tcmd_git.txt tcmd_sys.txt',
      \ 'options' : "--prompt '     '",
      \ 'sink'    : 'BmkEditItem',
      \ }
  else
    " Editor menu
    let opt = {
      \ 'source'  : 'fzf_bmk.sh --src bmk_file.txt vcmd.txt fzf.txt coc.txt ref.txt links.txt papers.txt',
      \ 'options' : "--prompt '      ' --preview 'preview_bmk.sh {}'",
      \ 'sink'    : 'BmkEditItem',
      \ }
  endif
  call fzf#run(fzf#wrap(opt))
endfunc

