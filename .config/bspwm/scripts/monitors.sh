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
# Migrate desktops from removed monitors
# ---------------------------
# Get list of monitors currently known to bspwm
BSPWM_MONITORS=($(bspc query -M --names))

# For each monitor bspwm knows about
for bspwm_mon in "${BSPWM_MONITORS[@]}"; do
    # Check if this monitor is still connected
    if ! printf '%s\n' "${CONNECTED[@]}" | grep -qx "$bspwm_mon"; then
        # Monitor is disconnected, move all its desktops to primary
        for desktop in $(bspc query -D -m "$bspwm_mon"); do
            bspc desktop "$desktop" --to-monitor "$PRIMARY"
        done
        # Remove the monitor from bspwm
        bspc monitor "$bspwm_mon" -r
    fi
done

# ---------------------------
# Configure monitors
# ---------------------------
if [ -n "$SECONDARY" ]; then
    bspc monitor "$PRIMARY" -d I II III IV
    bspc monitor "$SECONDARY" -d V VI VII VIII
    bspc wm --reorder-monitors "$PRIMARY" "$SECONDARY"
else
    bspc monitor "$PRIMARY" -d I II III IV V VI VII VIII
fi
