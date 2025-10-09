#!/bin/bash

# Source utility functions
DIR="$(dirname "${BASH_SOURCE[0]:-$0}")"
source "$DIR/../utils.sh"

# install fonts "$DIR/fonts/*.ttf" ONLY IF not already installed
for font in "$DIR/../fonts/"*; do
# only if file is not already present in the folder
    if [ ! -f ~/Library/Fonts/"$(basename "$font")" ]; then
        font_name=$(basename "$font")
        info "Installing font: $font_name"
        cp -n "$font" ~/Library/Fonts/
    else
        # Font already installed, skip silently
        :
    fi
done