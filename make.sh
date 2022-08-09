#!/bin/bash

#======================================================
# functions
#======================================================
f_default() {
  f_help
}

f_tags() {
  cd doc
  vim -e -c 'helptags . | quit'
}

f_help() {
  echo "default"
  echo "tags"
  echo "help"
}

#======================================================
# main
#======================================================
func_name=${1:-"default"}
eval "f_$func_name"


