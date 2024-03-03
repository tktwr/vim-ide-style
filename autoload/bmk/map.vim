func bmk#map#setup()
  if &filetype != "bmk"
    return
  endif

  if (vis#sidebar#inside())
    nnoremap <silent> <buffer> <CR>    :call bmk#item#EditItem(-2)<CR>
    nnoremap <silent> <buffer> <C-CR>  :call bmk#item#ViewItem(-2)<CR>
    nnoremap <silent> <buffer> <S-CR>  :call bmk#item#OpenItem(-2)<CR>

    nnoremap <silent> <buffer> l       :call bmk#item#PreviewItem(-2)<CR>
    nnoremap <silent> <buffer> j       :call bmk#item#NextItem()<CR>
    nnoremap <silent> <buffer> k       :call bmk#item#PrevItem()<CR>

    nnoremap <silent> <buffer> 2       :call bmk#item#EditItem(2)<CR>
    nnoremap <silent> <buffer> 3       :call bmk#item#EditItem(3)<CR>
    nnoremap <silent> <buffer> 4       :call bmk#item#EditItem(4)<CR>
    nnoremap <silent> <buffer> 5       :call bmk#item#EditItem(5)<CR>
    nnoremap <silent> <buffer> 6       :call bmk#item#EditItem(6)<CR>
    nnoremap <silent> <buffer> 7       :call bmk#item#EditItem(7)<CR>
    nnoremap <silent> <buffer> 8       :call bmk#item#EditItem(8)<CR>
    nnoremap <silent> <buffer> 9       :call bmk#item#EditItem(9)<CR>
  else
    nnoremap <silent> <buffer> <CR>    :call bmk#item#EditItem(0)<CR>
    nnoremap <silent> <buffer> <C-CR>  :call bmk#item#ViewItem(0)<CR>
    nnoremap <silent> <buffer> <S-CR>  :call bmk#item#OpenItem(0)<CR>
    if maparg('l') != ""
      nunmap <buffer> l
      nunmap <buffer> k
      nunmap <buffer> j
      nunmap <buffer> 2
      nunmap <buffer> 3
      nunmap <buffer> 4
      nunmap <buffer> 5
      nunmap <buffer> 6
      nunmap <buffer> 7
      nunmap <buffer> 8
      nunmap <buffer> 9
    endif
  endif
endfunc

