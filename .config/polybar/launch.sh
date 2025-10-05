#!/bin/bash

killall -q polybar
while pgrep -u "$UID" -x polybar >/dev/null; do sleep 1; done

MONITORS=($(polybar --list-monitors | cut -d':' -f1))
PRIMARY=$(polybar --list-monitors | awk '/primary/ {print $1}' | cut -d':' -f1)

if [ -z "$PRIMARY" ]; then
    PRIMARY="${MONITORS[0]}"
fi

MONITOR="$PRIMARY" polybar main &

for mon in "${MONITORS[@]}"; do
    [ "$mon" != "$PRIMARY" ] && MONITOR="$mon" polybar secondary &
done
