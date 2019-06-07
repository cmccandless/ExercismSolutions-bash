#!/usr/bin/env bash

set -o errexit
set -o nounset

CHR=( {a..z} )

#######################################
# Get ASCII code for character
# Arguments:
#   char    single character
# Source: https://unix.stackexchange.com/a/92448
#######################################
ord() {
  char="$1"
  LC_CTYPE=C printf '%d' "'$char"
}

START="$(ord a)"

main() {
  command="$1"
  a="$2"
  b="$3"
  text="$4"
  ([ -n "$a" ] && [ -n "$b" ]) || exit 1

  case "$command" in
    encode) 
      for (( i=0; i<${#text}; i++ )); do
        char="${text:$i:1}"
        o="$(ord $char)"
        encodedOrd="$(echo $(( (((a * (o - START)) + b) % 26) + START )))"
        encodedChar="${CHR[$encodedOrd]}"
        printf "%s" "$encodedChar"
      done
    ;;
    decode) ;;
  esac
}

main "$@"
