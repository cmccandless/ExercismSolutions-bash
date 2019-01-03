#!/usr/bin/env bash

set -o errexit
set -o nounset

main() {
  TZ=UTC date "+%a %b %-d %H:%M:%S %Z %Y" -d "$1 + 1000000000 seconds"
}

main "$@"
