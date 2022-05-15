func vis#util#VisExpand(url)
  let url = a:url
  if (url == "")
    let url = expand("<cfile>")
  endif
  return expand(url)
endfunc

func vis#util#VisExpandDir(url)
  let url = vis#util#VisExpand(a:url)
  let dir = bmk#BmkGetDirName(url)

  if (dir == "")
    let dir = expand("%:p:h")
  endif

  return dir
endfunc

func vis#util#VisUnexpand(dir)
  let dir = a:dir

  if !exists('s:unexpand_env_dict')
    let s:unexpand_env_dict = {}
    for i in g:vis#vis_unexpand_env_list
      if exists(i)
        let s:unexpand_env_dict[resolve(expand(i))] = i
      endif
    endfor
    let s:unexpand_env_dict[resolve(expand('$HOME'))] = '~'
  endif

  for i in reverse(sort(keys(s:unexpand_env_dict)))
    let dir = substitute(dir, '^'.i, s:unexpand_env_dict[i], '')
  endfor

  return dir
endfunc

func vis#util#VisCWD()
  if haslocaldir() == 1
    let l:type = "local"
    let l:cwd = getcwd()
  elseif haslocaldir() == 2
    let l:type = "tab"
    let l:cwd = getcwd(-1, 0)
  else
    let l:type = "global"
    let l:cwd = getcwd(-1)
  endif
  let l:cwd = vis#util#VisUnexpand(l:cwd)
  return "[".l:type.":".l:cwd."]"
endfunc

func vis#util#VisPrompt(prompt, word)
  let word = a:word
  if word == "?"
    let word = input(a:prompt)
  elseif word == "??"
    let text = expand('<cfile>')
    let word = input(a:prompt, text)
  endif
  if word == ""
    echo "Canceled"
  endif
  return word
endfunc

func vis#util#VisSetTab(nr)
  let &tabstop=a:nr
  let &shiftwidth=a:nr
endfunc

func vis#util#VisLineNumberToggle()
  set invnumber
  set invlist
endfunc

func vis#util#VisCheckEnv()
  echom "version: ".v:version
  echom "unix: ".has("unix")
  echom "win32unix: ".has("win32unix")
  echom "win32: ".has("win32")
  echom "win64: ".has("win64")
  echom "python: ".has("python")
  if has("python")
    py print(sys.version)
  endif
  echom "python3: ".has("python3")
  if has("python3")
    py3 print(sys.version)
  endif
  echom "gui_running: ".has("gui_running")
  echom "term: ".&term
  echom "shell: ".&shell
  echom "path: ".&path
  echom "runtimepath: ".&runtimepath
  echom "pwd:"
  pwd
endfunc

func vis#util#VisWinInfo()
  echom "columns               : &columns      : ".&columns
  echom "lines                 : &lines        : ".&lines
  echom "current win's width   : winwidth(0)   : ".winwidth(0)
  echom "current win's height  : winheight(0)  : ".winheight(0)
  echom "current win's winnr   : winnr()       : ".winnr()
  echom "last win's winnr      : winnr('$')    : ".winnr('$')
  echom "current win's bufnr   : winbufnr(0)   : ".winbufnr(0)
  echom "current buf's bufnr   : bufnr('%')    : ".bufnr('%')
  echom "current buf's bufname : bufname('%')  : ".bufname('%')
  echom "current buf's winnr   : bufwinnr('%') : ".bufwinnr('%')
  echom "current buf's winid   : bufwinid('%') : ".bufwinid('%')
endfunc

