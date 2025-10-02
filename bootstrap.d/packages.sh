#!/usr/bin/env bash
set -euo pipefail

BASE_PACKAGES=(
    git
    stow
    rsync
    python
    python-pip
    python-yaml
    python-pipx
    python
    pyenv
    bash-completion
    firefox
    vim
    tree
    flameshot
    noto-fonts-emoji
    xorg-xsetroot
    man-db
    networkmanager
    networkmanager-openvpn
    rofi
    rofi-emoji
    polybar
    xorg-xrandr
    jc
    jq
    unzip
    nemo
)

EXTRA_PACKAGES=(
  netbird-bin
  netbird-bin-debug
  netbird-debug
  netbird-ui-bin
  netbird-ui-bin-debug
  vscodium
  fluxcd
  kubectl
  kubelogin
  age
  sops
  helm
  docker
  python-poetry
  uv
  consul
  nomad
  vault
  go-task
  starship
  flameshot
  gitflow-avh
  git-delta
  signal-desktop
  discord
  devpod
  bluetuith
  dracula-icons-theme
  i3lock-color
)

install_pacman_packages() {
    echo "[PACKAGES] Installing base packages..."
    sudo pacman -Syu --needed --noconfirm "${BASE_PACKAGES[@]}"
}

install_extra_packages() {
    echo "[PACKAGES] Installing AUR packages..."
    for pkg in "${EXTRA_PACKAGES[@]}"; do
        if ! pacman -Qi "$pkg" &>/dev/null && ! yay -Q "$pkg" &>/dev/null; then
            echo "[AUR] Installing $pkg..."
            yay -S --needed --noconfirm "$pkg"
        else
            echo "[AUR] $pkg already installed, skipping."
        fi
    done
}


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
