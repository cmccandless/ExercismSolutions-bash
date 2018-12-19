#!/usr/bin/env bash

set -o errexit
set -o nounset

main() {
  input="${1}"

  if [ "$input" == "total" ]; then
    bc <<< "2 ^ (64) - 1"
  else
    if [[ $input -le 0 ]] || [[ $input -gt 64 ]]; then
      echo 'Error: invalid input'
      return 1
    fi
    bc <<< "2 ^ ($input - 1)"
  fi
}

main "$@"
