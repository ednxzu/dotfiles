#!/usr/bin/env bash
set -euo pipefail

echo "[BOOTSTRAP] Starting..."

# Install required base packages
source "$DOTFILES/bootstrap.d/packages.sh"
install_pacman_packages

# Run first stow
rm .bashrc .bash_logout
cd $DOTFILES
stow -d "$DOTFILES" -t "$HOME"
cd $HOME

# Install the rest of the packages
install_yay
install_extra_packages

# Install themes
source "$DOTFILES/bootstrap.d/theme.sh"

# Enable user systemd services
source "$DOTFILES/bootstrap.d/systemd.sh"

# Add sudoer files
source "$DOTFILES/bootstrap.d/sudoers.sh"

# Create git/ directory tree
source "$DOTFILES/bootstrap.d/git.sh"


echo "[BOOTSTRAP] Done!"
