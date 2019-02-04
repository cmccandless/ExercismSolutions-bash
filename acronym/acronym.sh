#!/usr/bin/env bash

set -o errexit
set -o nounset

main() {
  input="$(echo "${1//-/ }" | tr '[:lower:]' '[:upper:]')"

  for word in $input; do
    printf "%s" "${word:0:1}"
  done
  printf "\n"
}

main "$@"
