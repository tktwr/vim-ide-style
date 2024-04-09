#!/bin/bash

if [ "$VIM_TERMINAL" ]; then
  vimapi-cd $PWD
  vimapi_exec "VisShellPopup vimdiff.sh $1 $2"
fi
