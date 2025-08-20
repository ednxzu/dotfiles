#! /bin/bash

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

#############################
# Source helper functions #
#############################

if [ -f "$HOME/.bash_config.d/helpers.sh" ]; then
  . $HOME/.bash_config.d/helpers.sh
fi

#############################
# Source configuration file #
#############################

if [ -f "$HOME/.bash_config.d/config.sh" ]; then
  . $HOME/.bash_config.d/config.sh
fi

#########################
# History configuration #
#########################

# setting history length
HISTSIZE=1000
HISTFILESIZE=2000
# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend

# make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

#########################
# Environment variables #
#########################

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# color fzf menus for dracula theme
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=dark
  --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
  --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
  --color=border:#5fff87'

# set openstack clouds.yaml very explicit
export OS_CLIENT_CONFIG_FILE=$HOME/.config/openstack/clouds.yaml

#####################
# SSH configuration #
#####################

if is_true $USE_GNUPG_FOR_SSH; then
  export GPG_TTY="$(tty)"
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  gpgconf --launch gpg-agent
  gpg-connect-agent updatestartuptty /bye >/dev/null
fi

# ensure ssh won't break because of missing term files for kitty or alacritty
# the real TERM value should be xterm-kitty but won't work on most machines
export TERM=xterm-256color

########################
# Import configuration #
########################

if [ -f "/etc/bash_completion" ]; then
  . /etc/bash_completion
fi

source_all_files() {
  local dir_path="$1"

  if [ -d "$dir_path" ]; then
    for file in "$dir_path"/* "$dir_path"/.[!.]* "$dir_path"/..?*; do
      if [ -r "$file" ]; then
        . $file
      fi
    done
  fi
}

source_tool_configs() {
  local tools_dir="$1"

  if [ -d "$tools_dir" ]; then
    for subdir in "$tools_dir"/*/; do
      local include_file="${subdir}.include.sh"
      if [ -r "$include_file" ]; then
        . $include_file
      fi
    done
  fi
}

# Source alias configurations
source_all_files "$HOME/.bash_config.d/aliases.d"

# Source completion configurations
source_all_files "$HOME/.bash_config.d/completion.d"

# Source tool configurations
source_tool_configs "$HOME/.bash_config.d/tools.d"

# Source nachine specific configurations
source_all_files "$HOME/.bash_config.d/specific.d"

##############
# Local path #
##############

export PATH="$HOME/.local/bin:$PATH"

##############
# Cargo path #
##############

# source $HOME/.cargo/env

#######################
# PyEnv configuration #
#######################

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"

###############
# Final stage #
###############

# start starship
eval "$(starship init bash)"
