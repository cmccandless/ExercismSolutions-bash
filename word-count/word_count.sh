#!/usr/bin/env bash

set -o errexit

main() {
  input="${1//,/ }"

  declare -A words
  for word in $input; do
    word="$(tr -dc "[:alpha:][:digit:]'" <<<"${word,,}")"
    word="${word%%\'}"
    word="${word##\'}"
    current="${words[$word]}"
    [ -z "$current" ] && current=0
    words[$word]="$(( current + 1 ))"
  done
  for word in "${!words[@]}"; do
    printf "%s: %d\n" "$word" "${words[$word]}"
  done
}

main "$@"
