#!/bin/sh

CURSOR="left_ptr"
COMPOSE_KEY="ralt"

# Set cursor
xsetroot -cursor_name "$CURSOR"

# Reset and set desired XKB options
setxkbmap -option  # clears all
setxkbmap -option compose:"$COMPOSE_KEY"
