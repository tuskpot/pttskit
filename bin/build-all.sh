#!/usr/bin/env bash

# build-all.sh
# Build cards based on data in a data file.

# Use Aaron Maxwell's strict mode.
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# Set some default values.
out_dir="../out"

# Collect some parameters.
while getopts 'o:' flag; do
  case "${flag}" in
    o) out_dir="${OPTARG}";;
  esac
done

# Get input file.
file="${!OPTIND}"
dir=$(dirname "${file}")
echo "${file}"

# Make a card for each line in the CSV.
while IFS=, read -r -a line; do
  if [ "${line[5]}" == 'art' ]; then
    ./make-card.sh -n "${line[0]}" -t "${line[1]}" -b "${line[2]}" -o "${out_dir}" "${dir}/${line[4]}"
  else
    echo "${line[5]}"
  fi
done < "${file}"
