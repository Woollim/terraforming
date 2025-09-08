#!/bin/bash

# Update .zshrc with zshrc_temp

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSHRC_TEMP="$SCRIPT_DIR/zshrc_temp"
ZSHRC_TARGET="$HOME/.zshrc"

if [ ! -f "$ZSHRC_TEMP" ]; then
    echo "Error: zshrc_temp not found at $ZSHRC_TEMP"
    exit 1
fi

echo "Backing up current .zshrc..."
if [ -f "$ZSHRC_TARGET" ]; then
    cp "$ZSHRC_TARGET" "$ZSHRC_TARGET.backup.$(date +%Y%m%d_%H%M%S)"
    echo "Backup created: $ZSHRC_TARGET.backup.$(date +%Y%m%d_%H%M%S)"
fi

echo "Copying zshrc_temp to ~/.zshrc..."
cp "$ZSHRC_TEMP" "$ZSHRC_TARGET"

echo ".zshrc updated successfully!"
echo "Please reload your shell or run: source ~/.zshrc"