#!/bin/sh
# Force Firefox as default browser
xdg-settings set default-web-browser firefox.desktop

# Reinforce key MIME types
xdg-mime default firefox.desktop x-scheme-handler/http
xdg-mime default firefox.desktop x-scheme-handler/https
xdg-mime default firefox.desktop text/html
