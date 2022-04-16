func vis#internal#vimgrep#MyVimgrep(word, files)
  let word = vis#util#MyPrompt("Word? ", a:word)
  if word == ""
    return
  endif

  lcd %:h
  silent exec "vimgrep" word a:files
endfunc

