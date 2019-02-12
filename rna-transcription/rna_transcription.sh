#!/usr/bin/env bash

set -o errexit
set -o nounset

DNA='CGTA'
RNA='GCAU'

main() {
  input="${1:-}"
  if [ -n "$(tr -d "$DNA" <<<"$input")" ]; then
    echo "Invalid nucleotide detected."
    return 1
  fi
  tr "$DNA" "$RNA"<<<"$input"
}

main "$@"
