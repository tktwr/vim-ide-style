"------------------------------------------------------
" util
"------------------------------------------------------
func bmk#util#abspath(filepath)
  return fnamemodify(resolve(bmk#util#expand(a:filepath)), ':p')
endfunc

func bmk#util#dirname(filepath)
  let filepath = fnamemodify(expand(a:filepath), ':p')
  if (isdirectory(filepath))
    return filepath
  else
    return fnamemodify(filepath, ':h')
  endif
endfunc

"------------------------------------------------------
func bmk#util#expand(url)
  let url = a:url
  if (match(url, 'http\|https') == 0)
    return url
  endif
  return expand(url)
endfunc

func bmk#util#icon(url)
  let type = bmk#util#type(a:url)
  let type_to_icon = {
        \ 'http'         : ' ',
        \ 'network'      : ' ',
        \ 'dir'          : ' ',
        \ 'file'         : ' ',
        \ 'html'         : ' ',
        \ 'pdf'          : ' ',
        \ 'vim_normal'   : ' ',
        \ 'vim_command'  : ' ',
        \ 'term_command' : ' ',
        \ }
  return get(type_to_icon, type, '')
endfunc

func bmk#util#type(url)
  let url = a:url

  if (match(url, 'http\|https') == 0)
    let type = "http"
  elseif (match(url, '\.html$') != -1)
    let type = "html"
  elseif (match(url, '\.pdf$') != -1)
    let type = "pdf"
  elseif (match(url, '^//') == 0)
    let type = "network"
  elseif (match(url, '^\\') == 0)     " difficult to handle this format
    let type = "network"
  elseif (match(url, '^:') == 0)
    let type = "vim_command"
  elseif (match(url, '^> ') == 0)
    let type = "term_command"
  elseif (isdirectory(url))
    let type = "dir"
  elseif (filereadable(url))
    let type = "file"
  else
    let type = "vim_normal"
  endif

  return type
endfunc

"------------------------------------------------------
" buffer
"------------------------------------------------------
func bmk#util#clear()
  silent %d _
endfunc

func bmk#util#put0(text)
  silent 0put =a:text
endfunc

func bmk#util#put(text)
  silent put =a:text
endfunc

func bmk#util#RemoveBeginSpaces(line)
  return substitute(a:line, '^\s*', '', '')
endfunc

func bmk#util#RemoveEndSpaces(line)
  return substitute(a:line, '\s*$', '', '')
endfunc

func bmk#util#RemoveBeginEndSpaces(line)
  return bmk#util#RemoveBeginSpaces(bmk#util#RemoveEndSpaces(a:line))
endfunc

func bmk#util#system(cmd)
  let out = system(a:cmd)
  return substitute(out, "\<CR>", '', 'g')
endfunc

