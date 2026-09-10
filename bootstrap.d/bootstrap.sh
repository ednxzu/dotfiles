#!/usr/bin/env bash
set -euo pipefail

DOTFILES=$HOME/.dotfiles

echo "[BOOTSTRAP] Starting..."

# Run first stow
rm ${HOME}/.bashrc ${HOME}/.bash_logout

# Source yay installer
source "$DOTFILES/bootstrap.d/yay.sh"
install_yay

# Install mise (yh I know curl|sh unsafe)
curl https://mise.run | sh
mise --cd $DOTFILES trust
mise --cd $DOTFILES bootstrap

echo "[BOOTSTRAP] Done!"
