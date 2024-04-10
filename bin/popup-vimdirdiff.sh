#!/bin/bash

if [ "$VIM_TERMINAL" ]; then
  #vimapi-cd $PWD
  vimapi_exec "VisShellPopup vimdirdiff.sh $1 $2"
fi
