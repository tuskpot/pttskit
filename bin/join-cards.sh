#!/usr/bin/env bash

# join-cards.sh
# Use ImageMagick to join cards in a grid as an Tabletop Simulator templates.

# Use Aaron Maxwell's strict mode.
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# Set some default values.
cardw=418
cardh=585
cols=10
rows=7
img_out="../out/out.jpg"

# Collect some parameters.
while getopts 'c:o:r:' flag; do
  case "${flag}" in
    c) cols="${OPTARG}";;
    o) img_out="${OPTARG}";;
    r) rows="${OPTARG}";;
  esac
done
shift $((OPTIND-1))

# Get the art filenames.
imgs="$@"

# Combine inputs into a single output file.
IFS=$' '
montage \
 ${imgs} \
 -geometry "${cardw}x${cardh}" \
 -tile "${cols}x${rows}" \
 "${img_out}"

# Ensure final output is 4096px high, as recommended by TTS documentation.
mogrify -gravity North -extent x4096 "${img_out}"
