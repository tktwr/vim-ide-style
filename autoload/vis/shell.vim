func vis#shell#open(title, cmd_list, mods='')
  if a:mods == 'popup'
    call vis#popup_term#open(a:title, a:cmd_list)
  elseif a:mods == 'tab'
    exec printf("tab term ++close %s", join(a:cmd_list))
    let label = printf('%s', a:title)
    call vis#tabline#set_label(label)
  else
    exec printf("term ++curwin ++close %s", join(a:cmd_list))
  endif
endfunc

