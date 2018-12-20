#!/usr/bin/env bash

set -o errexit
set -o nounset

square_of_sum()
{
  echo $(( ($1 ** 4 + 2 * $1 ** 3  + $1 ** 2) / 4 ))
}

sum_of_squares()
{
  echo $(( $1 * ($1 + 1) * (2 * $1 + 1) / 6 ))
}

difference()
{
  echo $(( $(square_of_sum "$1") - $(sum_of_squares "$1") ))
}

"$@"
