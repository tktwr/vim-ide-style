"======================================================
" diff
"======================================================
func vis#internal#diff#open(file1, file2)
  let file1 = vis#util#abs_filepath(a:file1)
  let file2 = vis#util#abs_filepath(a:file2)
  exec "edit" file2
  exec "vertical diffsplit" file1
endfunc

