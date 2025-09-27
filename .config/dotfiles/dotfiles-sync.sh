#!/usr/bin/env bash
set -euo pipefail

export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket 2>/dev/null || true)

cd "$HOME/.dotfiles"

until git pull origin main; do
  echo "Waiting for SSH agent..."
  sleep 2
done

stow .
echo "[*] Dotfiles synced"
