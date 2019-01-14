#!/usr/bin/env bash

set -o errexit
set -o nounset

main() {
  if [[ ${#@} -lt 2 ]]; then
    printf "Usage: hamming.sh <strand1> <strand2>"
    return 1
  fi
  
  left="${1}"
  right="${2}"
  if [[ ${#left} != ${#right} ]]; then
    printf "left and right strands must be of equal length"
    return 1
  fi

  score=0
  for (( i=0; i<"${#left}"; i++ )); do
    [[ ${left:i:1} != ${right:i:1} ]] && (( score += 1))
  done
  printf "%d" "$score"
  return 0
}

main "$@"
