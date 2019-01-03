#!/usr/bin/env bash

set -o errexit
set -o nounset

main() {
  input="$(echo "${1}" | tr -dc '[:alnum:]')"
  score=0
  if [[ "${#input}" -eq 10 ]]; then
    for ((i=0; i<10; i++)); do
      ch="${input:i:1}"
      case "$ch" in
        X)
          if [[ "$i" -ne 9 ]]; then break; fi
          (( score += 10 ))
        ;;
        *[!0-9]*) score=0; break ;;
        *) (( score += ch * (10 - i) )) ;;
      esac
    done
  fi
  if (( score > 0 && score % 11 == 0 )); then
    printf "true"
  else
    printf "false"
  fi
}

main "$@"
