#!/usr/bin/env bash
set -euo pipefail

DOTFILES=$HOME/.dotfiles

echo "[BOOTSTRAP] Starting..."

# Install required base packages
source "$DOTFILES/bootstrap.d/packages.sh"
install_pacman_packages
get_mirror_list

# Run first stow
rm .bashrc .bash_logout
cd $DOTFILES
stow -d "$DOTFILES" -t "$HOME" .
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

# Install uv tools (python CLIs)
source "$DOTFILES/bootstrap.d/uv-tools.sh"
install_uv_tools

# Create git/ directory tree
source "$DOTFILES/bootstrap.d/git.sh"


echo "[BOOTSTRAP] Done!"
