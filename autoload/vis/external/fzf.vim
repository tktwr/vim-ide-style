"======================================================
" fzf
"======================================================
func vis#external#fzf#dirs()
  if FugitiveIsGitDir()
    let opt = {
      \ 'source'  : 'git-ls-dirs.sh',
      \ 'options' : "--prompt 'Git dirs > '",
      \ 'sink'    : 'BmkEditDir',
      \ 'dir'     : systemlist('git rev-parse --show-toplevel')[0],
      \ }
  else
    let opt = {
      \ 'source'  : 'fdfind --type d --strip-cwd-prefix',
      \ 'options' : "--prompt 'Fd dirs > '",
      \ 'sink'    : 'BmkEditDir',
      \ }
  endif
  call fzf#run(fzf#wrap(opt))
endfunc

func vis#external#fzf#files()
  if FugitiveIsGitDir()
    let opt = {
      \ 'source'  : 'git ls-files',
      \ 'options' : "--prompt 'Git files > ' --preview 'preview.sh {}'",
      \ 'sink'    : 'edit',
      \ 'dir'     : systemlist('git rev-parse --show-toplevel')[0],
      \ }
  else
    let opt = {
      \ 'source'  : 'fdfind --type f --strip-cwd-prefix',
      \ 'options' : "--prompt 'Fd files > ' --preview 'preview.sh {}'",
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
    let opt = {
      \ 'source'  : 'fzf_bmk.sh --src bmk_dir.txt',
      \ 'options' : "--prompt 'Bmk dirs > '",
      \ 'sink'    : 'BmkEditItem',
      \ }
  elseif &buftype == 'terminal'
    let opt = {
      \ 'source'  : 'fzf_bmk.sh --src bmk_dir.txt',
      \ 'options' : "--prompt 'Bmk dirs > '",
      \ 'sink'    : 'BmkEditItem',
      \ }
  else
    let opt = {
      \ 'source'  : 'fzf_bmk.sh --src bmk_file.txt',
      \ 'options' : "--prompt 'Bmk files > ' --preview 'preview_bmk.sh {}'",
      \ 'sink'    : 'BmkEditItem',
      \ }
  endif
  call fzf#run(fzf#wrap(opt))
endfunc

func vis#external#fzf#bmk_links()
  let opt = {
    \ 'source'  : 'fzf_bmk.sh --src links.txt',
    \ 'sink'    : 'BmkViewItem',
    \ }
  call fzf#run(fzf#wrap(opt))
endfunc

func vis#external#fzf#bmk_papers()
  let opt = {
    \ 'source'  : 'fzf_bmk.sh --src papers.txt',
    \ 'sink'    : 'BmkViewItem',
    \ }
  call fzf#run(fzf#wrap(opt))
endfunc
