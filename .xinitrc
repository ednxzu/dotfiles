#!/bin/sh

COMPOSE_KEY="ralt"

# Load Xresources (if present)
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# Reset and set desired XKB options
setxkbmap -option  # clears all
setxkbmap -option compose:"$COMPOSE_KEY"

# Finally start bspwm
exec bspwm -c ~/.config/bspwm/bspwmrc
