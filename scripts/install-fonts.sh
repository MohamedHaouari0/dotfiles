#!/usr/bin/env bash

set -e

FONT_DIR="$HOME/.local/share/fonts"

mkdir -p "$FONT_DIR"

if ! fc-list | grep -qi "JetBrainsMono Nerd Font"; then
    TMP=$(mktemp -d)

    curl -L \
        -o "$TMP/JetBrainsMono.zip" \
        https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip

    unzip -o "$TMP/JetBrainsMono.zip" -d "$FONT_DIR"

    fc-cache -fv

    rm -rf "$TMP"
fi
