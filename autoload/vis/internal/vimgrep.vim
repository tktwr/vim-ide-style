func vis#internal#vimgrep#open_prompt(word, files)
  let word = vis#util#prompt("Word? ", a:word)
  if word == ""
    return
  endif

  lcd %:h
  silent exec "vimgrep" word a:files
endfunc

