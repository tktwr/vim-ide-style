#!/bin/bash

if [ "$VIM_TERMINAL" ]; then
  vimapi-edit-file "$@"
else
  vim "$@"
fi
