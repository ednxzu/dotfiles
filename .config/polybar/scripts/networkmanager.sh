#!/bin/sh

WIFI_ICON=""
ETH_ICON="󰈀"
GREEN="#50fa7b"

network_print() {
    wifi_count=$(nmcli -t -f DEVICE,STATE,TYPE connection show --active | grep -c ":activated:802-11-wireless")
    eth_count=$(nmcli -t -f DEVICE,STATE,TYPE connection show --active | grep -c ":activated:802-3-ethernet")

    if [ "$wifi_count" -gt 0 ]; then
        wifi_out="%{F$GREEN}$WIFI_ICON ($wifi_count)%{F-}"
    else
        wifi_out="$WIFI_ICON (0)"
    fi

    if [ "$eth_count" -gt 0 ]; then
        eth_out="%{F$GREEN}$ETH_ICON ($eth_count)%{F-}"
    else
        eth_out="$ETH_ICON (0)"
    fi

    echo "$wifi_out  $eth_out"
}

trap exit INT

while true; do
    network_print

    timeout 60s nmcli monitor | while read -r _; do
        network_print
    done &

    wait
done
