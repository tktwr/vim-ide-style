func vis#external#quickhl#open_prompt(word)
  let word = vis#util#prompt("Word? ", a:word)
  if word == ""
    return
  endif

  exec "QuickhlManualAdd!" word
endfunc

