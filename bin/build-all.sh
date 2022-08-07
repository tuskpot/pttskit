#!/usr/bin/env bash

# build-all.sh
# Build cards based on data in a data file.

# Use Aaron Maxwell's strict mode.
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# Get input file.
file="${!OPTIND}"
dir=$(dirname "${file}")
echo "${file}"

# Make a card for each line in the CSV.
while IFS=, read -r -a line; do
  if [ ${line[4]} == 'art' ]; then
    ./make-card.sh -n "${line[0]}" -t "${line[1]}" "${dir}/${line[3]}"
  fi
done < "${file}"
