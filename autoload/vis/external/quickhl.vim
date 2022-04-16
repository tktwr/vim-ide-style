func vis#external#quickhl#MyQuickhl(word)
  let word = vis#util#MyPrompt("Word? ", a:word)
  if word == ""
    return
  endif

  exec "QuickhlManualAdd!" word
endfunc

