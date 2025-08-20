#! /bin/bash

install_docker() {
  local OS_ID="${1:-}"
  require_command apt-get
  require_command curl
  require_command install
  require_command chmod
  require_command dpkg
  require_command tee
  require_command chown
  require_command grep

  install_start "Docker" "apt latest"

  # Figure out OS_ID if not passed as argument
  if [[ -z "${OS_ID}" ]]; then
    OS_ID=$(grep '^ID=' /etc/os-release | cut -d= -f2)
  fi
  OS_CODENAME=$(grep '^VERSION_CODENAME=' /etc/os-release | cut -d= -f2)

  run_cmd "apt-get update"
  run_cmd "apt-get install -y ca-certificates curl"
  run_cmd "install -m 0755 -d /etc/apt/keyrings"
  run_cmd "curl -fsSL https://download.docker.com/linux/${OS_ID}/gpg -o /etc/apt/keyrings/docker.asc"
  run_cmd "chmod a+r /etc/apt/keyrings/docker.asc"

  # Pre-render the sources.list line!
  local DOCKER_APT_LINE="deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/${OS_ID} ${OS_CODENAME} stable"
  run_cmd "echo \"${DOCKER_APT_LINE}\" | tee /etc/apt/sources.list.d/docker.list > /dev/null"

  run_cmd "apt-get update"
  run_cmd "apt-get install -y docker-ce docker-ce-cli containerd.io"
  run_cmd "chown root:docker /var/run/docker.sock"

  install_end "Docker" "/usr/bin/docker --version"
}
