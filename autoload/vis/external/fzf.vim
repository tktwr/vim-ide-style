"======================================================
" fzf
"======================================================
func vis#external#fzf#dirs()
  if FugitiveIsGitDir()
    let opt = {
      \ 'source'  : 'git-ls-dirs.sh',
      \ 'sink'    : 'BmkEditDir',
      \ 'options' : "--prompt 'Git dirs > '",
      \ 'dir'     : systemlist('git rev-parse --show-toplevel')[0],
      \ }
  else
    let opt = {
      \ 'source'  : 'fdfind --type d --strip-cwd-prefix',
      \ 'sink'    : 'BmkEditDir',
      \ 'options' : "--prompt 'Fd dirs > '",
      \ }
  endif
  call fzf#run(fzf#wrap(opt))
endfunc

func vis#external#fzf#files()
  if FugitiveIsGitDir()
    let opt = {
      \ 'source'  : 'git ls-files',
      \ 'sink'    : 'edit',
      \ 'options' : "--prompt 'Git files > ' --preview 'preview.sh {}'",
      \ 'dir'     : systemlist('git rev-parse --show-toplevel')[0],
      \ }
  else
    let opt = {
      \ 'source'  : 'fdfind --type f --strip-cwd-prefix',
      \ 'sink'    : 'edit',
      \ 'options' : "--prompt 'Fd files > ' --preview 'preview.sh {}'",
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
      \ 'source'  : 'fzf_bmk.sh bmk_dir.txt',
      \ 'sink'    : 'BmkEditItem',
      \ 'options' : "--prompt 'Bmk dirs > '",
      \ }
  elseif &buftype == 'terminal'
    let opt = {
      \ 'source'  : 'fzf_bmk.sh bmk_dir.txt',
      \ 'sink'    : 'BmkEditItem',
      \ 'options' : "--prompt 'Bmk dirs > '",
      \ }
  else
    let opt = {
      \ 'source'  : 'fzf_bmk.sh bmk_file.txt',
      \ 'sink'    : 'BmkEditItem',
      \ 'options' : "--prompt 'Bmk files > ' --preview 'preview_bmk.sh {}'",
      \ }
  endif
  call fzf#run(fzf#wrap(opt))
endfunc

func vis#external#fzf#bmk_links()
  let opt = {
    \ 'source'  : 'fzf_bmk.sh links.txt',
    \ 'sink'    : 'BmkViewItem',
    \ }
  call fzf#run(fzf#wrap(opt))
endfunc

func vis#external#fzf#bmk_papers()
  let opt = {
    \ 'source'  : 'fzf_bmk.sh papers.txt',
    \ 'sink'    : 'BmkViewItem',
    \ }
  call fzf#run(fzf#wrap(opt))
endfunc
