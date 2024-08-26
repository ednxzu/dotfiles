#! /bin/bash

#############
# Variables #
#############
dotfiles_repo=$HOME/.dotfiles
bootstrap_packages=("nala" "python3" "python3-pip" "stow")

#############
# Bootstrap #
#############

function install_bootstrap_packages {
  for pkg in ${bootstrap_packages[@]}; do
    echo "sudo apt install -y $pkg"
  done
  echo "sudo apt install -y ${bootstrap_packages[@]}"
}

function source_config_file {
  if [ -f "$HOME/.bash_config.d/config.sh"]; then
    . $HOME/.bash_config.d/config.sh
  else
    echo "ERROR: file $HOME/.bash_config.d/config.sh not found"
    exit 1
  fi
}

function source_helpers_file {
  if [ -f "$HOME/.bash_config.d/helpers.sh"]; then
    . $HOME/.bash_config.d/helpers.sh
  else
    echo "ERROR: file $HOME/.bash_config.d/helpers.sh not found"
    exit 1
  fi
}

install_bootstrap_packages
