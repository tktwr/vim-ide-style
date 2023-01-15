#!/bin/bash

if [ "$VIM_TERMINAL" ]; then
  vimapi-edit-file `which "$1"` $2
else
  vim `which "$1"` $2
fi
