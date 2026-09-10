#! /usr/bin/env bash

install_yay() {
  if ! command -v yay &>/dev/null; then
    echo "[PACKAGES] Installing yay..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay
  else
    echo "[PACKAGES] yay already installed."
  fi
}
