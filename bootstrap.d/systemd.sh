#!/usr/bin/env bash
set -euo pipefail

echo "[SYSTEMD] Enabling user services..."

USER_SERVICES=(
    dotfiles-sync.service
    vscodium-sync.service
)

systemctl --user daemon-reload

for svc in "${USER_SERVICES[@]}"; do
    if [[ -f "$HOME/.config/systemd/user/$svc" ]]; then
        systemctl --user enable "$svc"
        echo "[SYSTEMD] Enabled user service $svc"
    else
        echo "[SYSTEMD] $svc not found, skipping."
    fi
done

echo "[SYSTEMD] Enabling global services..."

GLOBAL_SERVICES=(
    NetworkManager.service
)

sudo systemctl daemon-reload

for svc in "${GLOBAL_SERVICES[@]}"; do
    if systemctl list-unit-files | grep -q "^$svc"; then
        sudo systemctl enable "$svc"
        echo "[SYSTEMD] Enabled global service $svc"
    else
        echo "[SYSTEMD] $svc not found, skipping."
    fi
done
