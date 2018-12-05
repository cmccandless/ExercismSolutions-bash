#!/usr/bin/env bash

set -o errexit
set -o nounset

main() {
  input="${1}"

  if [ "$input" == "total" ]; then
    output=$(main 64)
    echo $(bc <<< "$output + $output - 1")
  else
    if [[ $input -le 0 ]] || [[ $input -gt 64 ]]; then
      echo 'Error: invalid input'
      return 1
    fi
    let output=1
    while [[ $input -gt 1 ]]; do
      output=$(bc <<< "$output * 2")
      let "input--"
    done
    echo "$output"
  fi
}

main "$@"
