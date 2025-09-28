#!/bin/sh
# ~/.xinitrc

# Load Xresources (if you want)
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# Start compositor if you use one (optional, e.g. picom)
# picom &

# Launch keybindings daemon
sxhkd &

# Finally start bspwm
exec bspwm
