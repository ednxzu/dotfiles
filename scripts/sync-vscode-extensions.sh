#!/usr/bin/env bash
set -euo pipefail

EXT_FILE=".config/VSCodium/extensions.list"

echo "[*] Exporting current VSCodium extensions..."
codium --list-extensions | sort -u > "$EXT_FILE"

if ! git diff --exit-code -- "$EXT_FILE"; then
  echo "[!] $EXT_FILE was updated — please git add it and retry your commit."
  exit 1
fi

echo "[*] $EXT_FILE is up to date"
