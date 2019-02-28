#!/usr/bin/env bash

set -o errexit
set -o nounset

RGX_VALID_PHONE_NUMBER='^1?[2-9][0-9]{2}[2-9][0-9]{6}$'

main() {
  input="${1}"

  clean="$(tr -dc '[:digit:]' <<< "$input")"
  if [[ $clean =~ $RGX_VALID_PHONE_NUMBER ]]; then
    echo "${clean##1}"
  else
    echo "Invalid number.  [1]NXX-NXX-XXXX N=2-9, X=0-9"
    return 1
  fi
}

main "$@"
