#!/usr/bin/env bash
set -euo pipefail

SUDOERS_SRC="$HOME/.dotfiles/bootstrap.d/sudoers.d"
SUDOERS_DST="/etc/sudoers.d"

echo "[SUDOERS] Installing sudoers files..."

for file in "$SUDOERS_SRC"/*; do
    if [[ -f "$file" ]]; then
        dst_file="$SUDOERS_DST/$(basename "$file")"
        echo "[SUDOERS] Copying $(basename "$file") to $SUDOERS_DST"
        sudo cp "$file" "$dst_file"
        sudo chmod 440 "$dst_file"
        sudo chown root:root "$dst_file"
    fi
done

echo "[SUDOERS] Done."
