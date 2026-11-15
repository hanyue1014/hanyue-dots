#!/usr/bin/env bash
set -euo pipefail

# Get the absolute path of the package directory (where this script lives)
PKG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CFG_DIR="$PKG_DIR/.config/niri/cfg"
OUTPUT_FILE="$CFG_DIR/keybinds_current.kdl"

echo "Setting up niri..."

# 1. Ensure the target configuration subdirectory exists
mkdir -p "$CFG_DIR"

# 2. Detect system keyboard layout
LAYOUT="us"

if command -v localectl &> /dev/null; then
    SYS_LAYOUT=$(localectl status 2>/dev/null | grep "X11 Layout" | awk '{print $3}')
    if [ -n "$SYS_LAYOUT" ]; then
        LAYOUT="$SYS_LAYOUT"
    fi
fi

echo "==> Detected keyboard layout: $LAYOUT"

# 3. Determine which keybinds file to include based on layout
if [ "$LAYOUT" = "jp" ]; then
    SOURCE_FILE="$CFG_DIR/keybinds_jis.kdl"
    LAYOUT_NAME="JIS (Japanese)"
else
    SOURCE_FILE="$CFG_DIR/keybinds_us.kdl"
    LAYOUT_NAME="US Standard"
fi

echo "==> Selected keybinds profile: $LAYOUT_NAME"

# 4. Copy the selected keybinds file to keybinds_current.kdl
if [ -f "$SOURCE_FILE" ]; then
    cp "$SOURCE_FILE" "$OUTPUT_FILE"
    echo "==> Successfully mapped $SOURCE_FILE to $OUTPUT_FILE"
else
    echo "Warning: Expected keybinds file '$SOURCE_FILE' was not found!" >&2
    # Fallback: create a basic stub if neither exists
    echo "// Fallback stub generated because $SOURCE_FILE was missing." > "$OUTPUT_FILE"
fi

echo "niri setup complete"