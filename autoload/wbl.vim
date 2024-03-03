func s:RemoveBufnr(lst, bufnr)
  let i = match(a:lst, a:bufnr)
  if i != -1
    call remove(a:lst, i)
  endif
endfunc

func s:TruncateList(lst, max)
  if (len(a:lst) > a:max)
    call remove(a:lst, a:max, -1)
  endif
endfunc

"------------------------------------------------------
func wbl#new()
  enew
endfunc

func wbl#push(bufnr)
  if !exists("w:buflist")
    let w:buflist = []
  endif

  call s:RemoveBufnr(w:buflist, a:bufnr)
  call insert(w:buflist, a:bufnr)
  call s:TruncateList(w:buflist, g:wbl_max)
endfunc

func wbl#pop()
  if len(w:buflist) == 1
    let bufnr = w:buflist[0]
    call wbl#new()
    call wbl#push(bufnr)
  endif

  if len(w:buflist) > 1
    call remove(w:buflist, 0)
    exec w:buflist[0]."b"
  endif
endfunc

