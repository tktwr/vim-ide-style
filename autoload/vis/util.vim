func vis#util#MyExpand(url)
  let url = a:url
  if (url == "")
    let url = expand("<cfile>")
  endif
  return expand(url)
endfunc

func vis#util#MyExpandDir(url)
  let url = vis#util#MyExpand(a:url)
  let dir = bmk#BmkGetDirName(url)

  if (dir == "")
    let dir = expand("%:p:h")
  endif

  return dir
endfunc

func vis#util#MyUnexpand(dir)
  let dir = a:dir
  let dir = substitute(dir, '^'.expand("$MY_PAPERS"), '$MY_PAPERS', "")
  let dir = substitute(dir, '^'.expand("$MY_GIT"), '$MY_GIT', "")
  let dir = substitute(dir, '^'.expand("$MY_WORK"), '$MY_WORK', "")
  let dir = substitute(dir, '^'.expand("$MY_PROJ"), '$MY_PROJ', "")
  let dir = substitute(dir, '^'.expand("$MY_DOC"), '$MY_DOC', "")
  let dir = substitute(dir, '^'.expand("$MY_OFFICE"), '$MY_OFFICE', "")
  let dir = substitute(dir, '^'.expand("$MY_DIARY"), '$MY_DIARY', "")
  let dir = substitute(dir, '^'.expand("$MY_MEMO"), '$MY_MEMO', "")
  let dir = substitute(dir, '^'.expand("$MY_ETC"), '$MY_ETC', "")
  let dir = substitute(dir, '^'.expand("$MY_ENV"), '$MY_ENV', "")
  let dir = substitute(dir, '^'.expand("$MY_REMOTE_CONFIG"), '$MY_REMOTE_CONFIG', "")
  let dir = substitute(dir, '^'.expand("$MY_LOCAL_CONFIG"), '$MY_LOCAL_CONFIG', "")
  let dir = substitute(dir, '^'.expand("$MY_PRIVATE_CONFIG"), '$MY_PRIVATE_CONFIG', "")
  let dir = substitute(dir, '^'.expand("$MY_PRIVATE"), '$MY_PRIVATE', "")
  let dir = substitute(dir, '^'.expand("$MY_PROTECTED"), '$MY_PROTECTED', "")
  let dir = substitute(dir, '^'.expand("$MY_PUBLIC"), '$MY_PUBLIC', "")
  let dir = substitute(dir, '^'.expand("$MY_DESKTOP"), '$MY_DESKTOP', "")
  let dir = substitute(dir, '^'.expand("$MY_DOWNLOADS"), '$MY_DOWNLOADS', "")
  let dir = substitute(dir, '^'.expand("$MY_HOME"), '^', "")
  let dir = substitute(dir, '^'.expand("$HOME"), '~', "")
  return dir
endfunc

func vis#util#MyCWD()
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
  let l:cwd = vis#util#MyUnexpand(l:cwd)
  return "[".l:type.":".l:cwd."]"
endfunc

func vis#util#MyPrompt(prompt, word)
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

func vis#util#MySetTab(nr)
  let &tabstop=a:nr
  let &shiftwidth=a:nr
endfunc

func vis#util#MyLineNumberToggle()
  set invnumber
  set invlist
endfunc

func vis#util#MyCheckEnv()
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

func vis#util#MyWinInfo()
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

