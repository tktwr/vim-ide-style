#!/bin/bash

vimapi-edit-file() {
  local file=$(pathconv.sh unix "$1")
  local winnr="${2:--1}"
  if [ -n "$file" ]; then
    vimapi.sh "call BmkEditFile('$file', $winnr)"
  fi
}

if [ "$VIM_TERMINAL" ]; then
  vimapi-edit-file "$@"
else
  vim "$@"
fi
