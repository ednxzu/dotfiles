#! /bin/bash

# Function to list available clouds using Python parser
list_clouds() {
  python3 $HOME/.bash_config.d/tools.d/oscs/extras/parse_clouds.py
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

# Function to get the fzf options
get_fzf_options() {
  if [[ -z "$FZF_DEFAULT_OPTS" ]]; then
    echo "--color=dark --color=fg:-1,bg:-1,hl:#eb1944,fg+:-1,bg+:-1,hl+:#eb1944 --color=info:#f8f8f2,prompt:#f8f8f2,pointer:#eb1944,marker:#ff87d7,spinner:#ff87d7 --color=border:#eb1944"
  else
    echo "$FZF_DEFAULT_OPTS"
  fi
}

# oscs function to switch OpenStack clouds
oscs() {
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

      local fzf_options=$(get_fzf_options)

      echo "Select a cloud environment:"
      local cloud=$(echo "$clouds_list" | fzf --height="$menu_height" --layout=reverse-list --border --prompt="Select cloud> " $fzf_options)

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
    echo "Usage: oscs {set [cloud_name] | unset}"
    ;;
  esac
}

# Autocomplete function for oscs
_oscs_autocomplete() {
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
complete -F _oscs_autocomplete oscs
