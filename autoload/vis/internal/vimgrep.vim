func vis#internal#vimgrep#VisVimgrep(word, files)
  let word = vis#util#VisPrompt("Word? ", a:word)
  if word == ""
    return
  endif

  lcd %:h
  silent exec "vimgrep" word a:files
endfunc

