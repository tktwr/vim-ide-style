func vis#util#abs_filepath(filepath)
  return fnamemodify(resolve(expand(a:filepath)), ':p')
endfunc

func vis#util#VisExpand(url)
  let url = a:url
  if (url == "")
    let url = expand("<cfile>")
  endif
  return expand(url)
endfunc

func vis#util#VisExpandDir(url)
  let url = vis#util#VisExpand(a:url)
  let dir = bmk#GetDirName(url)

  if (dir == "")
    let dir = expand("%:p:h")
  endif

  return dir
endfunc

func vis#util#VisUnexpand(dir)
  let dir = a:dir

  if !exists('s:unexpand_env_dict')
    let s:unexpand_env_dict = {}
    for i in g:vis_unexpand_env_list
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

func vis#util#VisGetCWD(winnr)
  let curr_winnr = winnr()
  call vis#window#goto(a:winnr)
  let l:cwd = getcwd(0, 0)
  call vis#window#goto(curr_winnr)
  return l:cwd
endfunc

func vis#util#VisCWD()
  if haslocaldir() == 1
    let type = "local"
    let cwd = getcwd(0, 0)
  elseif haslocaldir() == 2
    let type = "tab"
    let cwd = getcwd(-1, 0)
  else
    let type = "global"
    let cwd = getcwd(-1)
  endif
  let cwd = vis#util#VisUnexpand(cwd)
  return printf("[%s: %s]", type, cwd)
endfunc

" prompt:
"   prompt text
" word:
"   word: pass through
"   ?   : show input prompt
"   ??  : show input prompt with '<cfile>'
func vis#util#prompt(prompt, word)
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

func vis#util#set_tabstop(nr)
  let &tabstop=a:nr
  let &shiftwidth=a:nr
endfunc

func vis#util#line_number_toggle()
  set invnumber
  set invlist
endfunc

func vis#util#list_path(path)
  let lst = []
  for i in split(a:path, ',')
    let lst += ["  " . i]
  endfor
  return lst
endfunc

func vis#util#preview(buf_name, lines)
  exec "silent below pedit" a:buf_name
  wincmd P

  setlocal buftype=nofile
  setlocal nobuflisted
  setlocal noswapfile
  setlocal nonumber
  setf txt

  call setbufline(a:buf_name, 1, a:lines)
endfunc

func vis#util#output(title, lines)
  if vis#popup_win#has()
    call vis#popup_win#open(a:title, a:lines)
  else
    call vis#util#preview(a:title, a:lines)
  endif
endfunc

"------------------------------------------------------
func vis#util#check_env()
  let text  = []
  let text += ["version     : " . v:version]
  let text += ["unix        : " . has("unix")]
  let text += ["win32unix   : " . has("win32unix")]
  let text += ["win32       : " . has("win32")]
  let text += ["win64       : " . has("win64")]
  let text += ["python      : " . has("python")]
  let text += ["python3     : " . has("python3")]
  let text += ["gui_running : " . has("gui_running")]
  let text += ["term        : " . &term]
  let text += ["shell       : " . &shell]

  let text += ["path:"]
  let text += vis#util#list_path(&path)

  let text += ["runtimepath:"]
  let text += vis#util#list_path(&runtimepath)

  call vis#util#output("VisCheckEnv", text)

  " echom "pwd:"
  " verbose pwd
  "
  " if has("python")
  "   echom "python version:"
  "   py print(sys.version)
  " endif
  "
  " if has("python3")
  "   echom "python3 version:"
  "   py3 print(sys.version)
  " endif
endfunc

func vis#util#win_info()
  let text  = []
  let text += ["columns               : &columns      : " . &columns]
  let text += ["lines                 : &lines        : " . &lines]
  let text += ["current win's width   : winwidth(0)   : " . winwidth(0)]
  let text += ["current win's height  : winheight(0)  : " . winheight(0)]
  let text += ["current win's winnr   : winnr()       : " . winnr()]
  let text += ["last win's winnr      : winnr('$')    : " . winnr('$')]
  let text += ["current win's bufnr   : winbufnr(0)   : " . winbufnr(0)]
  let text += ["current buf's bufnr   : bufnr('%')    : " . bufnr('%')]
  let text += ["current buf's bufname : bufname('%')  : " . bufname('%')]
  let text += ["current buf's winnr   : bufwinnr('%') : " . bufwinnr('%')]
  let text += ["current buf's winid   : bufwinid('%') : " . bufwinid('%')]
  call vis#util#output("VisWinInfo", text)
endfunc

