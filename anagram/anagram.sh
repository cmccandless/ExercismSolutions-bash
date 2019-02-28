#!/usr/bin/env bash

set -o errexit
set -o nounset

str_to_chars()
{
  for (( i=0; i<${#1}; i++ )); do echo "${1:$i:1}"; done
}

clean()
{
  s="$(str_to_chars "$1" | sort)"
  echo "${s//[[:space:]]}"
}

main() {
  base_word="${1^^}"
  clean_word="$(clean "$base_word")"
  candidates=( $2 )

  # Add your code here
  results=()
  for c in "${candidates[@]}"; do
    if [ "${c^^}" != "$base_word" ] && [ "$(clean "${c^^}")" == "$clean_word" ]; then
      results+=($c)
    fi
  done
  if [ ! -z "${results:+x}" ]; then echo "${results[@]}"; fi
}

main "$@"
