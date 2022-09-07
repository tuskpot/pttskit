#!/usr/bin/env bash

# make-card.sh
# Use ImageMagick to make a card out of art and text inputs.

# Use Aaron Maxwell's strict mode.
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# Set some default values.
out_dir="../out"
file_mode="none"
card_num="0000"
card_title="Untitled"
card_body_text=""

# Collect some parameters.
while getopts 'b:m:n:o:t:' flag; do
  case "${flag}" in
    m) file_mode="${OPTARG}";;
    n) card_num="${OPTARG}";;
    t) card_title="${OPTARG}";;
    b) card_body_text="${OPTARG}";;
    o) out_dir="${OPTARG}";;
  esac
done

# Get the art filename.
img="${!OPTIND}"

# Set the output file name.
out_title=$(echo "${card_title}" | tr -c "a-zA-Z\r\n" "-" | tr "A-Z" "a-z")
mkdir -p "${out_dir}"
img_out="${out_dir}/${card_num}_${out_title}.jpg"

# Define the original file dimensions.
cardw=652
cardh=888
cardhh=444

# Define the art extents.
artw=594
arth=416

# Define the target image size and print resolution.
w=418
h=585
r=167

# Define the text box dimensions.
textw=600
texth=600

# Revert some substitutions in the body text.
card_clean_text=$(echo "${card_body_text}" | tr ";~" ",\n" | sed -E "s/(.{30,45}) /\1\n/g")

# Define font information.
font="Helvetica"
upper_title=$(echo "${card_title}" | tr "a-z" "A-Z")

# Define colors.
bg="#f7eec3"

# Resize, reposition and place art into an image.
convert "${img}" \
 -gravity South \
 -extent "${cardw}x${cardhh}" \
 -gravity North \
 -extent "${artw}x${arth}"\
 -resize "${w}" \
 -background "${bg}" \
 -gravity South \
 -extent "${w}x${h}" \
 -gravity NorthWest \
 -pointsize 24 \
 -font "${font}" \
 -annotate +80+40 "${upper_title}" \
 -pointsize 18 \
 -annotate +40+80 "${card_clean_text}" \
 "${img_out}"

