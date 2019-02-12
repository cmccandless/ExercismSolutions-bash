#!/usr/bin/env bash

set -o errexit
set -o nounset

le() {
  [[ 1 -eq "$(echo "$1 <= $2" | bc)" ]]
}

is_equilateral() {
  [[ "$1" == "$2" ]] && [[ "$2" == "$3" ]]
}

is_isosceles() {
  [[ "$1" == "$2" ]] || [[ "$2" == "$3" ]]
}

main() {
  type="${1}"
  sides=("$2" "$3" "$4")
  IFS=$'\n' sorted=( $(sort <<<"${sides[*]}") )
  a="${sorted[0]}"
  b="${sorted[1]}"
  c="${sorted[2]}"
  if ! le "$a" 0 && ! le "$a + $b" "$c"; then
    case "$type" in
      equilateral)
        if is_equilateral "$a" "$b" "$c"; then
          printf "true"
          return
        fi
      ;;
      isosceles)
        if is_isosceles "$a" "$b" "$c"; then
          printf "true"
          return
        fi
      ;;
      scalene)
        if ! is_isosceles "$a" "$b" "$c"; then
          printf "true"
          return
        fi
      ;;
    esac
  fi
  printf "false"
}

main "$@"
