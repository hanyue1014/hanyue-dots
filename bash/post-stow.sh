#!/usr/bin/env bash
set -euo pipefail

echo "Setting up bash"

# 1. Fetch git-prompt.sh into home directory (if not exist)
if ! [ -f $HOME/git-prompt.sh ] then
    GIT_PROMPT_URL="https://raw.githubusercontent.com/git/git/refs/heads/master/contrib/completion/git-prompt.sh"
    TARGET_PROMPT="$HOME/git-prompt.sh"

    echo "==> Downloading git-prompt.sh..."
    if command -v curl &> /dev/null; then
        curl -sLo "$TARGET_PROMPT" "$GIT_PROMPT_URL"
    elif command -v wget &> /dev/null; then
        wget -qO "$TARGET_PROMPT" "$GIT_PROMPT_URL"
    else
        echo "Error: Neither curl nor wget is available to download git-prompt.sh." >&2
        exit 1
    fi
fi

# 2. Manage ~/.pathrc for ~/.local/bin
PATHRC="$HOME/.pathrc"

if [ ! -f "$PATHRC" ]; then
    echo "==> Creating $PATHRC and adding ~/.local/bin..."
    echo "$PATH_ENTRY" > "$PATHRC"
else
    echo "==> Checking $PATHRC for ~/.local/bin..."
    if ! grep -q "\.local/bin" "$PATHRC"; then
        echo "==> Appending ~/.local/bin to $PATHRC..."
        echo "" >> "$PATHRC" # Ensure newline separation
        echo "~/.local/bin" >> "$PATHRC"
    else
        echo "==> ~/.local/bin is already present in $PATHRC."
    fi
fi

echo "bash setup successfully"