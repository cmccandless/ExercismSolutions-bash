#!/usr/bin/env bash

set -o errexit
set -o nounset

main() {
  input="$(echo "$1" | tr '[:upper:]' '[:lower:]')"

  score=0
  for (( i=0; i<${#input}; i++ )); do
    char="${input:$i:1}"
    case "$char" in
      a|e|i|o|u|l|n|r|s|t) (( score += 1 )) ;;
      d|g) (( score += 2 )) ;;
      b|c|m|p) (( score += 3 )) ;;
      f|h|v|w|y) (( score += 4 )) ;;
      k) (( score += 5 )) ;;
      j|x) (( score += 8 )) ;;
      q|z) (( score += 10 )) ;;
    esac
  done
  echo "$score"
}

main "$@"
