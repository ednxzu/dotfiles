#!/usr/bin/env bash
set -euo pipefail

CODIUM=/usr/bin/codium
EXT_FILE="$HOME/.config/VSCodium/extensions.list"

if [[ ! -f "$EXT_FILE" ]]; then
  echo "[!] No extensions.list found at $EXT_FILE, skipping."
  exit 0
fi

INSTALLED=$($CODIUM --list-extensions)

while IFS= read -r ext; do
  if [[ -n "$ext" && ! "$INSTALLED" =~ "$ext" ]]; then
    echo "[+] Installing $ext"
    $CODIUM --install-extension "$ext"
  fi
done < "$EXT_FILE"

echo "[*] VSCodium extensions synced"
