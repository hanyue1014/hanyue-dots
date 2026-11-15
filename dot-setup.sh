#!/usr/bin/env bash
set -euo pipefail

if [ $# -eq 0 ]; then
    echo "Error: No packages specified." >&2
    echo "Usage: $0 <package1> [package2]..." >&2
    echo "       $0 -D <package1> [package2]..." >&2
    exit 1
fi

# 1. Check if stow is available
if ! command -v stow &> /dev/null; then
    echo "Error: GNU stow is not installed. Please install it and try again." >&2
    exit 1
fi

# Define Stow flags as a safe Bash array (ignoring both hooks, targeting $HOME)
STOW_FLAGS=("--ignore=post-stow.sh" "--ignore=pre-unstow.sh" "-t" "$HOME")

# Detect if sparse-checkout is enabled in this repository
IS_SPARSE=false
if git rev-parse --git-dir &> /dev/null; then
    if [ "$(git config --get core.sparseCheckout || echo "false")" = "true" ]; then
        IS_SPARSE=true
    fi
fi

# 2. Handle removal flag (-D)
if [ "$1" = "-D" ]; then
    shift
    if [ $# -eq 0 ]; then
        echo "Error: No packages specified for removal." >&2
        exit 1
    fi

    PACKAGES_TO_REMOVE=("$@")

    echo "==> Unstowing packages: ${PACKAGES_TO_REMOVE[*]}"
    for pkg in "${PACKAGES_TO_REMOVE[@]}"; do
        if [ -d "$pkg" ]; then
            # Run pre-unstow hook if present before removing symlinks
            if [ -f "$pkg/pre-unstow.sh" ]; then
                echo "==> Running pre-unstow hook for $pkg..."
                if [ -x "$pkg/pre-unstow.sh" ]; then
                    "$pkg/pre-unstow.sh"
                else
                    bash "$pkg/pre-unstow.sh"
                fi
            fi

            stow -D "${STOW_FLAGS[@]}" "$pkg"
            echo "Unstowed $pkg successfully."
        else
            echo "Warning: Package directory '$pkg' not found locally, attempting stow removal anyway..." >&2
            stow -D "${STOW_FLAGS[@]}" "$pkg" || true
        fi
    done

    # Only update sparse-checkout if the repo is actually using sparse-checkout
    if [ "$IS_SPARSE" = true ]; then
        echo "==> Removing packages from sparse-checkout..."
        current_dirs=$(git sparse-checkout list 2>/dev/null || echo "")
        new_dirs=()

        for dir in $current_dirs; do
            keep=true
            for rem in "${PACKAGES_TO_REMOVE[@]}"; do
                if [ "$dir" = "$rem" ]; then
                    keep=false
                    break
                fi
            done
            if [ "$keep" = true ]; then
                new_dirs+=("$dir")
            fi
        done

        if [ ${#new_dirs[@]} -gt 0 ]; then
            git sparse-checkout set "${new_dirs[@]}"
        else
            git sparse-checkout disable
        fi
    fi

    echo "==> Unstow complete!"
    exit 0
fi

PACKAGES=("$@")

# 3. If sparse-checkout is active, add packages dynamically; otherwise skip
if [ "$IS_SPARSE" = true ]; then
    echo "==> Adding packages to sparse-checkout: ${PACKAGES[*]}"
    git sparse-checkout add "${PACKAGES[@]}"
    echo "==> Checking out target packages..."
    git checkout main
else
    echo "==> Sparse-checkout not active (full clone detected). Skipping git sparse adjustments."
fi

# 4. Run stow from the repo root and execute post-stow hooks if present
echo "==> Running GNU stow and hooks..."
for pkg in "${PACKAGES[@]}"; do
    if [ -d "$pkg" ]; then
        echo "Stowing $pkg..."
        stow "${STOW_FLAGS[@]}" "$pkg"

        # Check for post-stow hook inside the package directory
        if [ -f "$pkg/post-stow.sh" ]; then
            echo "==> Running post-stow hook for $pkg..."
            if [ -x "$pkg/post-stow.sh" ]; then
                "$pkg/post-stow.sh"
            else
                bash "$pkg/post-stow.sh"
            fi
        fi
    else
        echo "Warning: Package directory '$pkg' was not found in the repository, skipping." >&2
    fi
done

echo "==> Dotfiles setup complete!"