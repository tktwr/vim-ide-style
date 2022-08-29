#!/bin/bash

bin_name=`basename $0`

g_tapi="Tapi_Exec"
g_args=""

f_help() {
  echo "NAME"
  echo "  $bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $bin_name [options]"
  echo
  echo "OPTIONS"
  echo "  -h, --help     ... print help"
  echo "  --in-prev-win  ... exec in prev win"
  echo "  --in-above-win ... exec in above win"
  echo "  --in-new-tab   ... exec in new tab"
}

f_vimapi() {
  printf '\e]51;["call","%s","%s"]\x07' "$g_tapi" "$1" 1>&2
}

f_parse_args() {
  while [ $# -gt 0 ]; do
    case "$1" in
      -h|--help)
        f_help
        exit
        ;;
      --in-prev-win)
        g_tapi="Tapi_ExecInPrevWin"
        ;;
      --in-above-win)
        g_tapi="Tapi_ExecInAboveWin"
        ;;
      --in-new-tab)
        g_tapi="Tapi_ExecInNewTab"
        ;;
      --exec-echo)
        g_tapi="Tapi_ExecEcho"
        ;;
      *)
        g_args="$*"
        break
        ;;
    esac
    shift
  done
}

f_print_args() {
  echo "g_tapi = $g_tapi" 1>&2
  echo "g_args = $g_args" 1>&2
}

f_parse_args "$@"
#f_print_args
f_vimapi "$g_args"

