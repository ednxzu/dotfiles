#!/bin/bash

killall -q polybar
while pgrep -u "$UID" -x polybar >/dev/null; do sleep 1; done

MONITORS=($(polybar --list-monitors | cut -d':' -f1))
PRIMARY=$(polybar --list-monitors | awk '/primary/ {print $1}' | cut -d':' -f1)

if [ -z "$PRIMARY" ]; then
    PRIMARY="${MONITORS[0]}"
fi

if ls /sys/class/power_supply | grep -q '^BAT'; then
    BAR_MAIN="main-battery"
else
    BAR_MAIN="main"
fi

MONITOR="$PRIMARY" polybar "$BAR_MAIN" &

for mon in "${MONITORS[@]}"; do
    [ "$mon" != "$PRIMARY" ] && MONITOR="$mon" polybar secondary &
done
