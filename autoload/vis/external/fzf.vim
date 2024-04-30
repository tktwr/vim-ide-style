"======================================================
" fzf
"======================================================
func s:preview_win_opt()
  let options = []
  if vis#window#is_vertical()
    let options += ['--preview-window', 'down,75%']
    let options += ['--bind', 'alt-/:change-preview-window(hidden|)']
  else
    let options += ['--preview-window', 'right,60%']
    let options += ['--bind', 'alt-/:change-preview-window(down,75%|hidden|)']
  endif
  return options
endfunc

"------------------------------------------------------
" fzf#winbuf
"------------------------------------------------------
func s:winbuf_list()
  let l = []
  for i in w:buflist
    let s = printf("%3d %s ", i, bufname(i))
    call add(l, s)
  endfor
  return l
endfunc

func vis#external#fzf#winbuf()
  call vis#buffer#lcd_here()

  let source = s:winbuf_list()
  let prompt = 'Winbuf> '
  let options  = ['--prompt', prompt]

  let opt = {
    \ 'source'  : source,
    \ 'options' : options,
    \ 'window'  : {'width': 0.8, 'height': 0.5},
    \ 'sink'    : 'BmkEditWinbuf',
    \ }

  call fzf#run(fzf#wrap(opt))
endfunc

"------------------------------------------------------
" fzf#bmk
"------------------------------------------------------
func vis#external#fzf#bmk(query='')
  call vis#buffer#lcd_here()

  let is_git_dir = FugitiveIsGitDir() ? 1 : 0
  let prompt = is_git_dir ? 'Bmk( )> ' : 'Bmk> '

  " --- source ---
  let query = a:query
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

  " --- options ---
  let options  = ['--prompt', prompt]
  let options += ['--query', query]
  let options += ['--ansi']
  let options += ['--info', 'inline-right']
  let options += ['--header', '[A-oi] Open|Web, [A-/] Preview']
  let options += ['--bind', 'alt-o:execute(open.sh $(bmk_get_value.sh {}))']
  let options += ['--bind', 'alt-i:execute(open_web.sh $(bmk_get_value.sh {}))']
  let options += ['--preview', 'preview_bmk.sh {}']
  let options += s:preview_win_opt()

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
  call vis#buffer#lcd_here()

  let is_git_dir = FugitiveIsGitDir() ? 1 : 0
  let prompt = is_git_dir ? 'Fd( )> ' : 'Fd> '
  let base_dir = is_git_dir ? vis#util#git_root_dir() : '.'

  " --- source ---
  let source = printf('fd.sh %s', a:type)

  " --- sink ---
  let sink = a:sink
  if vis#sidebar#inside() && (&filetype == 'fern')
    let sink = 'BmkEditDir'
  endif

  " --- options ---
  let options  = ['--prompt', prompt]
  let options += ['--ansi']
  let options += ['--info', 'inline-right']
  let options += ['--header', '[A-adf] All|Dir|File, [A-oi] Open|Web, [A-/] Preview']
  let options += ['--bind', 'alt-a:reload(fd.sh a)']
  let options += ['--bind', 'alt-d:reload(fd.sh d)']
  let options += ['--bind', 'alt-f:reload(fd.sh f)']
  let options += ['--bind', 'alt-o:execute(open.sh {})']
  let options += ['--bind', 'alt-i:execute(open_web.sh {})']
  let options += ['--preview', 'preview.sh {}']
  let options += s:preview_win_opt()

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
  call vis#buffer#lcd_here()

  let is_git_dir = FugitiveIsGitDir() ? 1 : 0
  let prompt = is_git_dir ? 'Rg( )> ' : 'Rg> '
  let base_dir = is_git_dir ? vis#util#git_root_dir() : '.'
  let base_dir = fnamemodify(base_dir, ':p')
  exec "tcd" base_dir

  " --- source ---
  let query = a:query
  if query != ''
    let query = printf('-w %s', expand(query))
  endif

  let dirs = ""
  for i in a:dirs
    let dirs ..= printf(" '%s'", expand(i))
  endfor

  let rg_prefix = "rg.sh"
  let source = printf("%s %s %s", rg_prefix, query, dirs)
  let source_change = printf('change:reload:sleep 0.1; %s {q} %s || true', rg_prefix, dirs)

  " --- options ---
  let options  = ['--prompt', prompt]
  let options += ['--query', query]
  let options += ['--ansi']
  let options += ['--info', 'inline-right']
  let options += ['--header', '[-ws] Word|Case sensitive, [C-x] split, [A-ad] Select|Deselect all, [<TAB>] Select, [<multi:CR>] Quickfix, [A-/] Preview']
  let options += ['--disabled']
  let options += ['--bind', source_change]
  let options += s:preview_win_opt()

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
  call vis#buffer#lcd_here()

  let query = expand(a:query)

  let opt = fzf#vim#with_preview({
    \ "placeholder": "--tag {2}:{-1}:{3..}"
    \ })
  call fzf#vim#tags(query, opt, 0)
endfunc

func vis#external#fzf#tags_add()
  let word = expand('<cfile>')
  let file = expand('%:p')
  let line = printf('memo:bmk:%s	%s	/%s/;"	f', word, file, word)
  echom printf('memo:bmk: [%s] [%s]', word, file)
  let bmk_file = expand(g:vis_memo_bmk_file)
  call writefile([line], bmk_file, "a")
endfunc

"------------------------------------------------------
" fzf#gitstatus
"------------------------------------------------------
func vis#external#fzf#gitstatus()
  call vis#buffer#lcd_here()

  let options = ['--preview-window', 'down,80%']
  let opt = fzf#vim#with_preview({
    \ 'placeholder': '',
    \ 'options': options,
    \ })
  call fzf#vim#gitfiles('?', opt, 0)
endfunc

"------------------------------------------------------
" fzf#gitlog
"------------------------------------------------------
func vis#external#fzf#gitlog()
  call vis#buffer#lcd_here()

  let options = ['--preview-window', 'down,80%']
  let opt = fzf#vim#with_preview({
    \ 'placeholder': '',
    \ 'options': options,
    \ })
  1,$call fzf#vim#commits('', opt, 0)
endfunc

