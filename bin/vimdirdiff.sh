#!/bin/bash

if [ "$VIM_TERMINAL" ]; then
  vimapi.sh "call VisTabDirDiff('$1', '$2')"
else
  vim -c "call VisTabDirDiff('$1', '$2')"
fi
