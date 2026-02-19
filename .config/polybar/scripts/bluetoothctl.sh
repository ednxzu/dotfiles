#!/bin/sh

BT_ICON=""
RED="#ff5555"
BLUE="#8be9fd"

bluetooth_print() {
    if [ "$(systemctl is-active bluetooth.service)" != "active" ]; then
        echo "%{F$RED}$BT_ICON%{F-} OFF"
        return
    fi

    if bluetoothctl show | grep -q "Powered: no"; then
        echo "%{F$RED}$BT_ICON%{F-} OFF"
        return
    fi

    # bluez 5.86 broke non-interactive `bluetoothctl devices Connected` — it races
    # with adapter init and returns nothing. Piping forces it to wait for the session,
    # sed strips ANSI codes so grep can match cleanly.
    connected_devices=$(printf "devices Connected\n" | bluetoothctl 2>/dev/null | sed $'s/\033\\[[0-9;]*[mK]//g' | grep -c "^Device " || true)

    if [ "$connected_devices" -gt 0 ]; then
        echo "%{F$BLUE}$BT_ICON%{F-} ($connected_devices)"
    else
        echo "$BT_ICON (0)"
    fi
}

bluetooth_print
