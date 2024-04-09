#!/bin/bash

if [ "$VIM_TERMINAL" ]; then
  vimapi-cd $PWD
  vimapi_exec "call VisTabDirDiff('$1', '$2')"
fi
