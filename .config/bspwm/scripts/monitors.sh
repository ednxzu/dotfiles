#!/bin/sh

# ---------------------------
# Detect monitors
# ---------------------------
monitors=($(xrandr --query | awk '/ connected/{print $1}'))
num_monitors=${#monitors[@]}
primary="${monitors[0]}"

get_resolution() {
    xrandr --query | grep "^$1" | grep -oP '\d+x\d+' | head -1 | sed 's/x/ /'
}

read primary_width primary_height <<< "$(get_resolution "$primary")"

# ---------------------------
# Single-monitor setup
# ---------------------------
if [ "$num_monitors" -eq 1 ]; then
    bspc monitor "$primary" -d I II III IV
    exit 0
fi

# ---------------------------
# Multi-monitor setup
# ---------------------------
extra="${monitors[1]}"
read extra_width extra_height <<< "$(get_resolution "$extra")"

# ---------------------------
# Choose layout with rofi
# ---------------------------
direction=$(printf "← Left\n→ Right\n↑ Above\n↓ Below" | rofi -dmenu -i -p "Place extra monitor:" \
    -theme-str '@import "powermenu.rasi"' \
    -kb-custom-1 "Alt+1" \
    -kb-custom-2 "Alt+2" \
    -kb-custom-3 "Alt+3" \
    -kb-custom-4 "Alt+4")

exit_code=$?

# Map exit codes from Alt+1..4 to directions
case $exit_code in
    10) direction="← Left" ;;
    11) direction="→ Right" ;;
    12) direction="↑ Above" ;;
    13) direction="↓ Below" ;;
esac

# Default to right if no selection
[ -z "$direction" ] && direction="→ Right"

# ---------------------------
# Position monitors
# ---------------------------
case "$direction" in
    "← Left")
        x_offset=0
        y_offset=$((primary_height - extra_height))
        xrandr --output "$extra" --auto --pos "${x_offset}x${y_offset}" --left-of "$primary"
        ;;
    "→ Right")
        x_offset=$((primary_width))
        y_offset=$((primary_height - extra_height))
        xrandr --output "$extra" --auto --pos "${x_offset}x${y_offset}" --right-of "$primary"
        ;;
    "↑ Above")
        x_offset=$(( (primary_width - extra_width) / 2 ))
        y_offset=$(( -extra_height ))
        xrandr --output "$extra" --auto --pos "${x_offset}x${y_offset}" --above "$primary"
        ;;
    "↓ Below")
        x_offset=$(( (primary_width - extra_width) / 2 ))
        y_offset=$(( primary_height ))
        xrandr --output "$extra" --auto --pos "${x_offset}x${y_offset}" --below "$primary"
        ;;
esac

# ---------------------------
# Assign desktops
# ---------------------------
bspc monitor "$primary" -d I II III IV
bspc monitor "$extra"   -d V VI VII VIII

# ---------------------------
# Info for logs / debugging
# ---------------------------
notify-send "🖥️ BSPWM" "Primary: $primary (I–IV)\nExtra: $extra (V–VIII)\nLayout: $direction"
