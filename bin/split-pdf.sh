#!/usr/bin/env bash

# split-pdf.sh
# Use ImageMagick to split PDF pages into individual images.

# Use Aaron Maxwell's strict mode.
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# Set some default values.
density=300
cardw=418
cardh=585
img_out="../out/out.jpg"

# Collect some parameters.
while getopts 'o:' flag; do
  case "${flag}" in
    o) img_out="${OPTARG}";;
  esac
done

# Get the pdf filename.
pdf="${!OPTIND}"

# Extract individual pages into separate files.
IFS=$' '
convert \
 -density "${density}" \
 "${pdf}" \
 -geometry "${cardw}x${cardh}" \
 "${img_out}"
