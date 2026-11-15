#!/usr/bin/env bash
set -euo pipefail

echo "Removing bash configuration..."

# 1. Remove git-prompt.sh from home directory
TARGET_PROMPT="$HOME/git-prompt.sh"
if [ -f "$TARGET_PROMPT" ]; then
    echo "==> Removing $TARGET_PROMPT..."
    rm "$TARGET_PROMPT"
fi

# 2. Remove the ~/.local/bin entry from ~/.pathrc if it exists
PATHRC="$HOME/.pathrc"
PATH_ENTRY='~/.local/bin'

if [ -f "$PATHRC" ]; then
    echo "==> Checking $PATHRC for ~/.local/bin entry..."
    if grep -q "\.local/bin" "$PATHRC"; then
        echo "==> Removing ~/.local/bin entry from $PATHRC..."
        # Use a temporary file with fixed-string matching to safely filter out the entry
        grep -vF "$PATH_ENTRY" "$PATHRC" > "$PATHRC.tmp" && mv "$PATHRC.tmp" "$PATHRC"
    fi
fi

echo "==> Pre-unstow tasks completed successfully!"