func vis#external#quickhl#open_prompt(word)
  let word = vis#util#VisPrompt("Word? ", a:word)
  if word == ""
    return
  endif

  exec "QuickhlManualAdd!" word
endfunc

