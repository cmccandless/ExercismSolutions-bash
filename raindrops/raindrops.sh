#!/usr/bin/env bash

set -o errexit
set -o nounset

mod()
{
  let "r = $1 % $2"; return $r
}

main() {
  input="${1}"
  code=''
  mod $input 3 && code+='Pling'
  mod $input 5 && code+='Plang'
  mod $input 7 && code+='Plong'
  echo "${code:-$input}"
}

main "$@"
