#! /bin/bash

DEBIAN_FRONTEND=noninteractive
GLOBAL_INSTALL_DIR="/usr/local/bin"
LOCAL_INSTALL_DIR="${HOME}/.local/bin"
GLOBAL_COMPLETION_DIR="/etc/bash_completion.d"
LOCAL_COMPLETION_DIR="${HOME}/.bash_config.d/completion.d"

# Colors
COLOR_RESET="\033[0m"
COLOR_INFO="\033[34m"    # Blue
COLOR_SUCCESS="\033[32m" # Green
COLOR_WARN="\033[33m"    # Yellow
COLOR_ERROR="\033[31m"   # Red

log_info() {
  echo -e "${COLOR_INFO}[INFO]${COLOR_RESET} $1"
}

log_success() {
  echo -e "${COLOR_SUCCESS}[SUCCESS]${COLOR_RESET} $1"
}

log_warn() {
  echo -e "${COLOR_WARN}[WARNING]${COLOR_RESET} $1"
}

log_error() {
  echo -e "${COLOR_ERROR}[ERROR]${COLOR_RESET} $1" >&2
}

install_start() {
  log_info "Starting installation of $1 version $2"
}

install_end() {
  if [ $? -eq 0 ]; then
    log_success "$1 installed successfully"
    if [ -n "$2" ]; then
      log_info "$1 version: $($2)"
    fi
  else
    log_error "Installation of $1 failed"
    exit 1
  fi
}

run_cmd() {
  eval "$1"
  if [ $? -ne 0 ]; then
    log_error "Command failed: $1"
    exit 1
  fi
}

require_command() {
  if ! command -v "$1" &>/dev/null; then
    log_error "Required command '$1' not found. Please install it first."
    exit 1
  fi
}

confirm() {
  read -r -p "${1:-Are you sure? [y/N]} " response
  case "$response" in
    [yY][eE][sS]|[yY]) true ;;
    *) false ;;
  esac
}
