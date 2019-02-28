#!/usr/bin/env bash

set -o errexit
set -o nounset

str_to_chars()
{
  for (( i=0; i<${#1}; i++ )); do echo "${1:$i:1}"; done
}

main() {
  input="${1:-}"
  input="$(tr -dc '[:alpha:]' <<< "${input,,}")"
  unique_letters="$(str_to_chars "$input" | sort | uniq | tr -d "\n")"
  [ "${#unique_letters}" -eq "${#input}" ] && echo 'true' || echo 'false'
}

main "$@"
