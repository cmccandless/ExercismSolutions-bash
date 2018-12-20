#!/usr/bin/env bash

set -o errexit
set -o nounset

main() {
  n="${1}"

  if [ $n -le 0 ]; then
    echo 'Error: Only positive numbers are allowed'
    return 1
  fi

  for (( steps=0; $n>1; steps++)); do
    (( n = (n & 1) ? 3 * n + 1 : n / 2 ))
  done
  echo $steps
}

main "$@"
