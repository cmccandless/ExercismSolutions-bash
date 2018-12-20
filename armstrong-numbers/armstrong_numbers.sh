#!/usr/bin/env bash

set -o errexit
set -o nounset

main() {
  input="${1}"

  sum=0
  for (( i=0; i<${#input}; i++ )); do
    (( sum += ${input:$i:1} ** ${#input} ))
  done
  [[ $sum == $input ]] && echo 'true' || echo 'false'
}

main "$@"
