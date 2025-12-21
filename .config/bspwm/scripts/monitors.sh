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
    # Two monitor setup - ensure we have exactly 8 desktops with correct names
    # Get all current desktops
    ALL_DESKTOPS=($(bspc query -D --names))

    # Ensure we have 8 desktops, create if missing
    for i in I II III IV V VI VII VIII; do
        if ! printf '%s\n' "${ALL_DESKTOPS[@]}" | grep -qx "$i"; then
            bspc monitor "$PRIMARY" -a "$i"
        fi
    done

    # Move desktops to correct monitors
    for desktop in I II III IV; do
        bspc desktop "$desktop" --to-monitor "$PRIMARY"
    done
    for desktop in V VI VII VIII; do
        bspc desktop "$desktop" --to-monitor "$SECONDARY"
    done

    # Remove any extra desktops that might exist
    for desktop in $(bspc query -D --names); do
        if ! printf '%s\n' I II III IV V VI VII VIII | grep -qw "$desktop"; then
            bspc desktop "$desktop" --remove
        fi
    done

    bspc wm --reorder-monitors "$PRIMARY" "$SECONDARY"
else
    # Single monitor setup - ensure all 8 desktops exist with correct names
    ALL_DESKTOPS=($(bspc query -D --names))

    # Ensure we have 8 desktops, create if missing
    for i in I II III IV V VI VII VIII; do
        if ! printf '%s\n' "${ALL_DESKTOPS[@]}" | grep -qx "$i"; then
            bspc monitor "$PRIMARY" -a "$i"
        fi
    done

    # Move all desktops to primary
    for desktop in I II III IV V VI VII VIII; do
        bspc desktop "$desktop" --to-monitor "$PRIMARY"
    done

    # Remove any extra desktops
    for desktop in $(bspc query -D --names); do
        if ! printf '%s\n' I II III IV V VI VII VIII | grep -qw "$desktop"; then
            bspc desktop "$desktop" --remove
        fi
    done
fi
