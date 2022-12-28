func vis#map#setup()
  if &diff == 1
    nnoremap <buffer> <C-P>   [c
    nnoremap <buffer> <C-N>   ]c
  else
    nnoremap <buffer> <C-P>   :cp<CR>
    nnoremap <buffer> <C-N>   :cn<CR>
  endif
endfunc

