"======================================================
" diff
"======================================================
func vis#internal#diff#open(file1, file2, tab=v:true)
  let file1 = vis#util#abs_filepath(a:file1)
  let file2 = vis#util#abs_filepath(a:file2)

  if !(filereadable(file1) && filereadable(file2))
    echom printf("ERROR: diff: cannot open files")
    echom printf("file1: [%s]", file1)
    echom printf("file2: [%s]", file2)
    return
  endif

  if a:tab
    tabedit
  endif

  let file1 = substitute(file1, ' ', '\\ ', 'g')
  let file2 = substitute(file2, ' ', '\\ ', 'g')
  exec "edit" file2
  exec "vertical diffsplit" file1
endfunc

