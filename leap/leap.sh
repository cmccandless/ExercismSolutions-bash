#!/usr/bin/env bash

set -o errexit
set -o nounset

# mod()
# {
#   let "$1 % $2 == 0"
#   [[ -z $result ]]
# }

is_not_integer()
{
  echo $1 | grep -E '[^0-9]' &> /dev/null
}

mod()
{
  let "r = $1 % $2"; return $r
}

main() {
  if [ "${#@}" -ne 1 ] || is_not_integer $1; then
    echo 'Usage: leap.sh <year>'
    return 1
  fi
  if mod $1 4 && (! mod $1 100 || mod $1 400); then
    echo 'true'
  else
    echo 'false'
  fi
}

main "$@"
