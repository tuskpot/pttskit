#!/usr/bin/env bash

# join-cards.sh
# Use ImageMagick to join cards in a grid as an Tabletop Simulator templates.

# Use Aaron Maxwell's strict mode.
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# Set some default values.
bg="#f7eec3"
cardw=418
cardh=585
cols=10
rows=7
img_out="../out/out.jpg"

# Collect some parameters.
while getopts 'c:h:o:r:w:' flag; do
  case "${flag}" in
    c) cols="${OPTARG}";;
    o) img_out="${OPTARG}";;
    r) rows="${OPTARG}";;
    w) cardw="${OPTARG}";;
    h) cardh="${OPTARG}";;
  esac
done
shift $((OPTIND-1))

# Set the maximum number of images.
max_img=$(((cols * rows) - 1))

# Get the art filenames.
imgs="${@}"

# Insert placeholder images for every 70th card.
# Oh, despite the documentation, this isn't necessary.
#imgs=( )
#while [ ${#} -ge ${max_img} ]; do
  #imgs=("${imgs[@]}" "${@:1:max_img}" "null:")
  #shift "${max_img}"
#done
#imgs=("${imgs[@]}" "${@}")

# Combine inputs into a single output file.
IFS=$' '
montage \
 ${imgs} \
 -background "${bg}" \
 -geometry "${cardw}x${cardh}" \
 -tile "${cols}x${rows}" \
 "${img_out}"

# Ensure final output is 4096px high, as recommended by TTS documentation.
# (How best to handle multiple output files?)
#mogrify -gravity North -extent x4096 "${img_out}"
