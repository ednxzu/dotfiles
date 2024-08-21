#!/bin/bash

# Function to check if a value is "true"
is_true() {
  case "$1" in
  1 | [Tt]rue | [Yy]es) return 0 ;;
  *) return 1 ;;
  esac
}

# Function to log messages (optional)
log() {
  echo "[$(date +'%Y-%m-%d %H:%M:%S')] $@"
}
