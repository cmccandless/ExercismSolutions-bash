#!/usr/bin/env bash

set -o errexit
set -o nounset

main() {
  case "${#@}" in
    0) echo 'Usage: ./error_handling <greetee>' ;;
    1) echo "Hello, $1"; return 0 ;;
  esac
  return 1
}

main "$@"
