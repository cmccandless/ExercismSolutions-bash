#!/usr/bin/env bash

set -o errexit
set -o nounset

main() {
  input="${1}"
  code=''
  (( $input % 3 )) || code+='Pling'
  (( $input % 5 )) || code+='Plang'
  (( $input % 7 )) || code+='Plong'
  echo "${code:-$input}"
}

main "$@"
