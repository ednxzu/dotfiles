#!/usr/bin/env bash
set -euo pipefail

GIT_HOME="$HOME/git"
CONFIG_DIR="$HOME/.gitconfig.d"

mkdir -p "$GIT_HOME"

shopt -s dotglob  # include dotfiles in globs

for cfg in "$CONFIG_DIR"/*.config; do
    [[ -f "$cfg" ]] || continue

    base=$(basename "$cfg")
    dir_name="${base#.}"
    dir_name="${dir_name%.config}"
    mkdir -p "$GIT_HOME/$dir_name"
    echo "[*] Created directory: $GIT_HOME/$dir_name"
done

mkdir -p "$GIT_HOME/ansible_collections"
echo "[*] Created directory: $GIT_HOME/ansible_collections"

echo "[*] Git directories setup complete."
