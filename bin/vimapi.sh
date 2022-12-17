#!/bin/bash

f_vimapi() {
  local tapi=$1
  shift
  printf '\e]51;["call","%s","%s"]\x07' "$tapi" "$*" 1>&2
}

f_vimapi "$@"

