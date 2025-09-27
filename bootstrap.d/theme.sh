#!/usr/bin/env bash
set -euo pipefail

THEMES_DIR="$HOME/.themes"
CONFIG_DIR="$HOME/.config"
ICONS_DIR="$HOME/.local/share/icons"

mkdir -p "$THEMES_DIR" "$ICONS_DIR" "$CONFIG_DIR/gtk-4.0"

# -----------------------
# Install GTK theme
# -----------------------
if [[ ! -d "$THEMES_DIR/dracula" ]]; then
    echo "[THEME] Cloning Dracula GTK theme..."
    git clone --depth 1 https://github.com/dracula/gtk.git "$THEMES_DIR/dracula"
else
    echo "[THEME] Dracula GTK theme already installed."
fi

# -----------------------
# Install circle icons
# -----------------------
DRACULA_ICONS_ZIP="$ICONS_DIR/circle.zip"
DRACULA_ICONS_DIR="$ICONS_DIR/dracula-circle"
if [[ ! -d "$DRACULA_ICONS_DIR" ]]; then
    echo "[ICONS] Downloading Dracula circle icons..."
    curl -L -o "$DRACULA_ICONS_ZIP" "https://github.com/m4thewz/dracula-icons/archive/refs/heads/circle.zip"
    unzip -q "$DRACULA_ICONS_ZIP" -d "$ICONS_DIR"
    mv -f "$ICONS_DIR/dracula-icons-circle" "$DRACULA_ICONS_DIR"
    rm "$DRACULA_ICONS_ZIP"
else
    echo "[ICONS] Dracula circle icons already installed."
fi

# -----------------------
# Install cursor icons
# -----------------------
DRACULA_CURSORS_DIR="$ICONS_DIR/dracula-cursors"
if [[ ! -d "$DRACULA_CURSORS_DIR" ]]; then
    echo "[CURSORS] Installing Dracula cursors..."
    git clone --depth 1 https://github.com/dracula/gtk.git /tmp/dracula-gtk
    cp -r /tmp/dracula-gtk/kde/cursors/Dracula-cursors "$DRACULA_CURSORS_DIR"
    rm -rf /tmp/dracula-gtk
else
    echo "[CURSORS] Dracula cursors already installed."
fi

# -----------------------
# Symlink GTK theme files
# -----------------------
GTK_CONFIG="$CONFIG_DIR/gtk-4.0"
THEME_PATH="$THEMES_DIR/dracula/gtk-4.0"

echo "[THEME] Setting Dracula theme in $GTK_CONFIG..."
ln -sf "$THEME_PATH/gtk.css" "$GTK_CONFIG/gtk.css"
ln -sf "$THEME_PATH/gtk-dark.css" "$GTK_CONFIG/gtk-dark.css"
ln -sf "$THEME_PATH/assets" "$GTK_CONFIG/assets"
ln -sf "$THEMES_DIR/dracula/assets" "$HOME/.config/assets"

echo "[THEME] Dracula theme installed and activated!"
