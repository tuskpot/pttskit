#!/usr/bin/env bash

# cmyk-to-rgb.sh
# Use ImageMagick to convert images from a CMYK profile to an RGB profile.

# Use Aaron Maxwell's strict mode.
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# Modify each file to the new profile.
IFS=$' '
for file in "$@"
do
  mogrify \
   +profile icm \
   -profile "../profiles/adobe/CMYK/USWebCoatedSWOP.icc" \
   -profile "../profiles/icc/sRGB_ICC_v4_Appearance.icc" \
   "${file}"
done
