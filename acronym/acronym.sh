#!/usr/bin/env bash

set -o errexit
set -o nounset

main() {
  input="$(tr '[:lower:]' '[:upper:]' <<<"${1//-/ }")"

  for word in $input; do
    printf "%s" "${word:0:1}"
  done
  printf "\n"
}

main "$@"
