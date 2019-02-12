#!/usr/bin/env bash

set -o errexit
set -o nounset

is_not_integer()
{
  grep -E '[^0-9]' &> /dev/null <<<"$1"
}

main() {
  if [ "${#@}" -ne 1 ] || is_not_integer "$1"; then
    echo 'Usage: leap.sh <year>'
    return 1
  fi
  # if mod $1 4 && (! mod $1 100 || mod $1 400); then
  if (( $1 % 4 == 0 )) && ( (( $1 % 100 != 0 )) || (( $1 % 400 == 0 )) ); then
    echo 'true'
  else
    echo 'false'
  fi
}

main "$@"
