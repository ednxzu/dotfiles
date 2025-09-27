#!/usr/bin/env bash
set -euo pipefail

echo "[DCONF] Applying GNOME settings..."

# Example: enable night light
dconf write /org/gnome/settings-daemon/plugins/color/night-light-enabled true

# You can import a full dconf dump if you have one:
# dconf load / < "$HOME/.dotfiles/dconf-settings.dump"
