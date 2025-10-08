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

    connected_devices=$(bluetoothctl devices Connected | wc -l)

    if [ "$connected_devices" -gt 0 ]; then
        echo "%{F$BLUE}$BT_ICON%{F-} ($connected_devices)"
    else
        echo "$BT_ICON (0)"
    fi
}

bluetooth_print
