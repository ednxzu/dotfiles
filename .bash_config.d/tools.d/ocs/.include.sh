#! /bin/bash

# Function to list available clouds using Python parser
list_clouds() {
  python3 ~/git/github/dotfiles/.bash_config.d/tools.d/ocs/extras/parse_clouds.py
}

# Function to check if a cloud name exists
cloud_exists() {
  local cloud_name="$1"
  if list_clouds | grep -q "^${cloud_name}$"; then
    return 0 # Cloud exists
  else
    return 1 # Cloud does not exist
  fi
}

# ocs function to switch OpenStack clouds
ocs() {
  case "$1" in
  set)
    if [[ -z "$2" ]]; then
      # No cloud name provided, show interactive menu with fzf
      local clouds_list=$(list_clouds)
      local num_clouds=$(echo "$clouds_list" | wc -l)

      # Determine the height of the fzf menu
      local menu_height=$((num_clouds + 4))
      if [[ $menu_height -gt 14 ]]; then
        menu_height=14
      fi

      echo "Select a cloud environment:"
      local cloud=$(echo "$clouds_list" | fzf --height="$menu_height" --layout=reverse-list --border --prompt="Select cloud> ")

      if [[ -n "$cloud" ]]; then
        export OS_CLOUD="$cloud"
        echo "Switched to cloud: $OS_CLOUD"
      else
        echo "No cloud selected."
      fi
    else
      # Cloud name provided, validate and set it
      if cloud_exists "$2"; then
        export OS_CLOUD="$2"
        echo "Switched to cloud: $OS_CLOUD"
      else
        echo "Error: Cloud '$2' does not exist."
        return 1
      fi
    fi
    ;;
  unset)
    unset OS_CLOUD
    echo "OS_CLOUD variable has been unset"
    ;;
  *)
    echo "Usage: ocs {set [cloud_name] | unset}"
    ;;
  esac
}

# Autocomplete function for ocs
_ocs_autocomplete() {
  local cur_word="${COMP_WORDS[COMP_CWORD]}"

  if [[ ${COMP_CWORD} -eq 2 && "${COMP_WORDS[1]}" == "set" ]]; then
    # Autocomplete cloud names when "set" is the first argument
    COMPREPLY=($(compgen -W "$(list_clouds)" -- "$cur_word"))
  elif [[ ${COMP_CWORD} -eq 1 ]]; then
    # Autocomplete "set" and "unset" as first arguments
    COMPREPLY=($(compgen -W "set unset" -- "$cur_word"))
  fi
}

# Register the autocompletion function
complete -F _ocs_autocomplete ocs
