#!/usr/bin/env bash

set -o errexit
set -o nounset

nucleotides='A C G T'

valid()
{
  filt="$1"
  for n in $nucleotides; do
    filt="${filt//$n}"
  done
  [ -z "$filt" ]
}

main() {
  input="${1:-}"
  if ! valid "$input"; then
    echo "Invalid nucleotide in strand"
    return 1
  fi

  for nucleotide in $nucleotides; do
    filt="$input"
    for not in $nucleotides; do
      [[ "$nucleotide" != "$not" ]] && filt="${filt//$not}"
    done
    echo "$nucleotide: ${#filt}"
  done
}

main "$@"
