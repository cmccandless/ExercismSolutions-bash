#!/usr/bin/env bash

set -o errexit
set -o nounset

yelling()
{
  # contains letters?
  [[ "$1" =~ [[:alpha:]]  ]] &&
  # all uppercase?
  [ "$1" == "${1^^}" ] &&
  echo '!Y'
}

asking()
{
  # has trailing question mark?
  [ "$1" != "${1%\?}" ] &&
  echo '!A'
}

main() {
  input="${1:-}"

  # Strip trailing whitespace
  input="${input%"${input##*[![:space:]]}"}"

  case "$(yelling "$input")$(asking "$input")$input" in
    '!Y!A'*) echo "Calm down, I know what I'm doing!";;
    '!Y'*) echo "Whoa, chill out!";;
    '!A'*) echo "Sure.";;
    '') echo "Fine. Be that way!";;
    *) echo "Whatever.";;
  esac
}

main "$@"
