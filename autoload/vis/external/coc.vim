func vis#external#coc#str2icon(str)
  let str2icon = {
        \ 'clangd'   : ' ',
        \ 'json'     : ' ',
        \ 'pyright'  : ' ',
        \ 'tsserver' : ' ',
        \ 'vimlsp'   : ' ',
        \ }
  let icon = get(str2icon, a:str, '')
  if icon == ''
    return a:str
  else
    return icon
  endif
endfunc

func vis#external#coc#services()
  if !g:coc_service_initialized
    return '[LS: not ready]'
  endif

  let services = CocAction('services')
  let str = ''
  for srv in services
    if srv['state'] == 'running'
      let str ..= printf('%s', vis#external#coc#str2icon(srv['id']))
    endif
  endfor
  return printf('[LS: %s]', str)
endfunc

