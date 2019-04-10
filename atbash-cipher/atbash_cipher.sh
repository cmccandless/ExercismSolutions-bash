#!/usr/bin/env bash
#
# Encode/Decode text using Atbash Cipher
#
# usage: atbash_cipher.sh {encode, decode} <text>

set -o errexit
set -o nounset

REV=( {z..a} )

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

#######################################
# Sanitize input text, removing non-
# alphanumeric characters and transforming
# alphabetic characters to lowercase.
#######################################
clean() {
  input="${1:-}"
  input="${input//[^[:alpha:][:digit:]]/}"
  echo "${input,,}"
}

#######################################
# Insert a space every $chunksize characters
#######################################
addSpacing() {
  chunksize="${1:-5}"
  read -r -n "$chunksize" -s chunk
  printf '%s' "$chunk"
  while read -r -n "$chunksize" -s chunk; do
    if [ -n "$chunk" ]; then
      printf ' %s' "$chunk"
    fi
  done
}

#######################################
# Implementation of `tr [:alpha:] $(rev<<<[:alpha:])`,
#######################################
transcode() {
  output=''
  while read -r -n 1 -s ch; do
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
    encode) clean "$2" | transcode | addSpacing 5 ;;
    decode) clean "$2" | transcode;;
  esac
}

main "$@"

