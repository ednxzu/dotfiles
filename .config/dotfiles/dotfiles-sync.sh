#!/usr/bin/env bash
set -euo pipefail

export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket 2>/dev/null || true)

DOTFILES=$HOME/.dotfiles

cd $DOTFILES

until git pull origin main; do
  echo "[D] Waiting for SSH agent..."
  sleep 2
done

${HOME}/.local/bin/mise --cd $DOTFILES bootstrap --yes

echo "[*] Dotfiles synced"
