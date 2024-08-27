#!/bin/bash

DEFAULT_VENV_DIR="$HOME/.venvs"

get_venv_dir() {
  echo "${PYV_DIRECTORY:-$DEFAULT_VENV_DIR}"
}

ensure_venv_dir() {
  local venv_dir
  venv_dir=$(get_venv_dir)

  if [[ ! -d "$venv_dir" ]]; then
    echo "Virtual environments directory '$venv_dir' does not exist. Creating it..."
    mkdir -p "$venv_dir"
    if [[ $? -eq 0 ]]; then
      echo "Directory created successfully."
    else
      echo "Error: Failed to create directory '$venv_dir'."
      exit 1
    fi
  fi
}

list_venvs() {
  local venv_dir
  venv_dir=$(get_venv_dir)
  find "$venv_dir" -maxdepth 1 -mindepth 1 -type d -exec basename {} \;
}

get_fzf_options() {
  if [[ -z "$FZF_DEFAULT_OPTS" ]]; then
    echo "--color=dark --color=fg:-1,bg:-1,hl:#eb1944,fg+:-1,bg+:-1,hl+:#eb1944 --color=info:#f8f8f2,prompt:#f8f8f2,pointer:#eb1944,marker:#ff87d7,spinner:#ff87d7 --color=border:#eb1944"
  else
    echo "$FZF_DEFAULT_OPTS"
  fi
}

create_venv() {
  local venv_name="$1"
  if [[ -z "$venv_name" ]]; then
    echo "Please enter the name of the new virtual environment:"
    read -r venv_name
    if [[ -z "$venv_name" ]]; then
      echo "Error: No virtual environment name provided."
      return 1
    fi
  fi

  local venv_dir
  venv_dir=$(get_venv_dir)
  local venv_path="$venv_dir/$venv_name/$venv_name"

  echo "Creating virtual environment in $venv_path..."
  mkdir -p "$venv_dir/$venv_name"
  python3 -m venv "$venv_path"

  if [[ $? -eq 0 ]]; then
    echo "Virtual environment '$venv_name' created successfully."
    source "$venv_path/bin/activate"
    echo "Activated virtual environment: $venv_name"
  else
    echo "Error: Failed to create virtual environment '$venv_name'."
    return 1
  fi
}

save_requirements() {
  local no_version=false
  if [[ "$1" == "--no-version" ]]; then
    no_version=true
  fi

  if [[ -z "$VIRTUAL_ENV" ]]; then
    echo "No virtual environment is currently activated."
    return 1
  fi

  local venv_name=$(basename "$VIRTUAL_ENV")
  local requirements_file="$(dirname "$VIRTUAL_ENV")/requirements.txt"

  if $no_version; then
    pip freeze | sed 's/==.*//' >"$requirements_file"
  else
    pip freeze >"$requirements_file"
  fi

  if [[ $? -eq 0 ]]; then
    echo "Requirements saved to $requirements_file"
  else
    echo "Error: Failed to save requirements."
    return 1
  fi
}

install_requirements() {
  if [[ -z "$VIRTUAL_ENV" ]]; then
    echo "No virtual environment is currently activated."
    return 1
  fi

  local requirements_file="$(dirname "$VIRTUAL_ENV")/requirements.txt"

  if [[ -f "$requirements_file" ]]; then
    pip install -r "$requirements_file"
    if [[ $? -eq 0 ]]; then
      echo "Requirements installed successfully from $requirements_file"
    else
      echo "Error: Failed to install requirements."
      return 1
    fi
  else
    echo "No requirements.txt found in the current virtual environment."
    return 1
  fi
}

pyv() {
  ensure_venv_dir

  case "$1" in
  activate)
    local venv_name="$2"
    if [[ -n "$venv_name" ]]; then
      local activate_script="$(get_venv_dir)/$venv_name/$venv_name/bin/activate"
      if [[ -f "$activate_script" ]]; then
        source "$activate_script"
        echo "Activated virtual environment: $venv_name"
      else
        echo "The virtual environment '$venv_name' does not exist. Would you like to create it? [y/N]"
        read -r response
        if [[ "$response" == "y" || "$response" == "Y" ]]; then
          create_venv "$venv_name"
        else
          echo "No action taken."
        fi
      fi
    else
      local venvs_list=$(list_venvs)
      local num_venvs=$(echo "$venvs_list" | wc -l)

      local menu_height=$((num_venvs + 4))
      if [[ $menu_height -gt 14 ]]; then
        menu_height=14
      fi

      local fzf_options=$(get_fzf_options)

      echo "Select a Python virtual environment to activate:"
      local venv=$(echo "$venvs_list" | fzf --height="$menu_height" --layout=reverse-list --border --prompt="Select venv> " $fzf_options)

      if [[ -n "$venv" ]]; then
        local activate_script="$(get_venv_dir)/$venv/$venv/bin/activate"
        if [[ -f "$activate_script" ]]; then
          source "$activate_script"
          echo "Activated virtual environment: $venv"
        else
          echo "The virtual environment '$venv' does not exist. Would you like to create it? [y/N]"
          read -r response
          if [[ "$response" == "y" || "$response" == "Y" ]]; then
            create_venv "$venv"
          else
            echo "No action taken."
          fi
        fi
      else
        echo "No virtual environment selected."
      fi
    fi
    ;;
  deactivate)
    if [[ "$VIRTUAL_ENV" != "" ]]; then
      deactivate
      echo "Virtual environment deactivated."
    else
      echo "No virtual environment is currently activated."
    fi
    ;;
  save)
    save_requirements "$2"
    ;;
  install)
    install_requirements
    ;;
  create)
    create_venv "$2"
    ;;
  "")
    pyv activate
    ;;
  *)
    echo "Usage: pyv {activate [venv_name] | deactivate | save [--no-version] | install | create [venv_name]}"
    ;;
  esac
}

_pyv_autocomplete() {
  local cur_word="${COMP_WORDS[COMP_CWORD]}"
  local prev_word="${COMP_WORDS[COMP_CWORD - 1]}"

  if [[ ${COMP_CWORD} -eq 1 ]]; then
    COMPREPLY=($(compgen -W "activate deactivate save install create" -- "$cur_word"))
  elif [[ "$prev_word" == "activate" || "$prev_word" == "create" ]]; then
    local venvs_list=$(list_venvs)
    COMPREPLY=($(compgen -W "$venvs_list" -- "$cur_word"))
  fi
}

complete -F _pyv_autocomplete pyv
