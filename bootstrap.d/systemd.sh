#!/usr/bin/env bash
set -euo pipefail

echo "[SYSTEMD] Enabling user services..."

SERVICES=(
    dotfiles-sync.service
    vscodium-sync.service
)

for svc in "${SERVICES[@]}"; do
    if [[ -f "$HOME/.config/systemd/user/$svc" ]]; then
        systemctl --user daemon-reload
        systemctl --user enable "$svc"
        echo "[SYSTEMD] Enabled $svc"
    else
        echo "[SYSTEMD] $svc not found, skipping."
    fi
done
