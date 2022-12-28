"======================================================
" diff
"======================================================
func vis#internal#diff#VisTabDiff(file1, file2)
  exec "tabedit" a:file2
  exec "vertical diffsplit" a:file1
endfunc

