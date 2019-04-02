#!/usr/bin/env bash

set -o errexit
set -o nounset

REV=( {z..a} )

# https://unix.stackexchange.com/a/92448
ord() {
  LC_CTYPE=C printf '%d' "'$1"
}

START="$(ord a)"

clean() {
  input="${1:-}"
  input="${input//[^[:alpha:][:digit:]]/}"
  echo "${input,,}"
}

addSpacing() {
  timeout=0.5
  chunksize=5
  read -r -t "$timeout" -n "$chunksize" -s chunk
  printf '%s' "$chunk"
  while read -r -t "$timeout" -n "$chunksize" -s chunk; do
    if [ -n "$chunk" ]; then
      printf ' %s' "$chunk"
    fi
  done
}

transcode() {
  output=''
  while read -r -t 0.5 -n 1 -s ch; do
    if [ -n "$ch" ]; then
      if [[ "$ch" =~ [a-z] ]]; then
        ch="${REV[$(( $(ord "$ch") - START ))]}"
      fi
      output+="$ch"
      # printf '%s' "$ch"
    fi
  done
  echo "$output"
}

main() {
  case "$1" in
    encode) clean "$2" | transcode | addSpacing ;;
    decode) clean "$2" | transcode;;
  esac
}

main "$@"

