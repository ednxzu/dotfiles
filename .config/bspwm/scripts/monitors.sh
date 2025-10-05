#!/bin/sh

PREFERRED_PRIMARY="eDP-1"

# Detect all connected monitors
CONNECTED=($(xrandr --query | awk '/ connected/ {print $1}'))

# Determine primary
if printf '%s\n' "${CONNECTED[@]}" | grep -qx "$PREFERRED_PRIMARY"; then
    PRIMARY="$PREFERRED_PRIMARY"
else
    PRIMARY="${CONNECTED[0]}"
fi

# Determine secondary (any other monitor)
SECONDARY=""
for mon in "${CONNECTED[@]}"; do
    [ "$mon" != "$PRIMARY" ] && SECONDARY="$mon" && break
done

# ---------------------------
# Configure monitors
# ---------------------------
if [ -n "$SECONDARY" ]; then
    bspc monitor "$PRIMARY" -d I II III IV
    bspc monitor "$SECONDARY" -d V VI VII VIII
else
    bspc monitor "$PRIMARY" -d I II III IV V VI VII VIII
fi
