#!/usr/bin/env bash

set -o errexit
set -o nounset

main() {
  [ "$(tr '[:upper:]' '[:lower:]'<<<"${1:-}" | \
    fold -w1 | \
    sort -u | \
    tr -cd '[:alpha:]' | \
    wc -c)" -eq 26 ] && echo "true" || echo "false"
}

main "$@"
