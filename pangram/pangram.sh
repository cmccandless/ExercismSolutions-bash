#!/usr/bin/env bash

set -o errexit
set -o nounset

count_unique_letters()
{
  tr '[:upper:]' '[:lower:]'<<<"${1:-}" |
    fold -w1 |
    sort -u |
    tr -cd '[:alpha:]' |
    wc -c
}

main() {
  [ "$(count_unique_letters "$1")" -eq 26 ] && echo "true" || echo "false"
}

main "$@"
