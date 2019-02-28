#!/usr/bin/env bash

set -o errexit
set -o nounset

LETTERS=( {A..Z} )

# https://unix.stackexchange.com/a/92448
ord() {
  LC_CTYPE=C printf '%d' "'$1"
}

START="$(ord A)"

chr() {
  printf "%s" "${LETTERS[$(( $1 - START))]}"
}

write_spaces()
{
  for _ in $(seq 0 "$1"); do printf " "; done
}

write_row()
{
  char="$(chr "$ch")"
  outer_spacing="$(write_spaces "$(( stop - ch - 1 ))")"
  inner_spacing="$(write_spaces "$(( (ch - START - 1) * 2 ))")"
  printf "%s%s" "$outer_spacing" "$char"
  [ "$ch" != "$START" ] && printf "%s%s" "$inner_spacing" "$char"
  printf "%s\n" "$outer_spacing"
}

main() {
  stop="$(ord "$1")"
  for ch in $(seq "$START" "$stop") $(seq "$(( stop - 1))" -1 "$START"); do
    write_row
  done
}

main "$@"
