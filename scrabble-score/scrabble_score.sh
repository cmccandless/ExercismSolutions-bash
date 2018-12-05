#!/usr/bin/env bash

set -o errexit
set -o nounset

main() {
  input="$(echo $1 | tr '[:upper:]' '[:lower:]')"

  score=0
  for (( i=0; i<${#input}; i++ )); do
    char="${input:$i:1}"
    case "$char" in
      a|e|i|o|u|l|n|r|s|t) let "score+=1" ;;
      d|g) let "score+=2" ;;
      b|c|m|p) let "score+=3" ;;
      f|h|v|w|y) let "score+=4" ;;
      k) let "score+=5" ;;
      j|x) let "score+=8" ;;
      q|z) let "score+=10" ;;
    esac
  done
  echo "$score"
}

main "$@"
