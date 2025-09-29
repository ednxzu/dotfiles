#!/bin/sh
# ~/.xinitrc

# Load Xresources (if present)
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# Finally start bspwm
exec bspwm -c ~/.config/bspwm/bspwmrc
