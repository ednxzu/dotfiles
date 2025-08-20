#! /bin/bash

install_consul() {
  # renovate: datasource=github-releases depName=hashicorp/consul
  CONSUL_VERSION="v1.21.3"
  CONSUL_VERSION_STRIPPED="${CONSUL_VERSION#v}"
  CONSUL_TMP_ZIP="/tmp/consul_${CONSUL_VERSION_STRIPPED}_linux_amd64.zip"
  CONSUL_TMP_DIR="/tmp/consul"
  CONSUL_INSTALL_BIN="${LOCAL_INSTALL_DIR}/consul"

  require_command curl
  require_command unzip
  require_command mv
  require_command chmod
  require_command rm
  require_command mkdir

  install_start "consul" "${CONSUL_VERSION}"

  run_cmd "curl --silent --fail -Lo \"${CONSUL_TMP_ZIP}\" \
    \"https://releases.hashicorp.com/consul/${CONSUL_VERSION_STRIPPED}/consul_${CONSUL_VERSION_STRIPPED}_linux_amd64.zip\""
  run_cmd "mkdir -p \"${CONSUL_TMP_DIR}\""
  run_cmd "unzip -q \"${CONSUL_TMP_ZIP}\" -d \"${CONSUL_TMP_DIR}\""
  run_cmd "mv \"${CONSUL_TMP_DIR}/consul\" \"${CONSUL_INSTALL_BIN}\""
  run_cmd "chmod +x \"${CONSUL_INSTALL_BIN}\""
  run_cmd "rm -rf \"${CONSUL_TMP_ZIP}\" \"${CONSUL_TMP_DIR}\""

  install_end "consul" "${CONSUL_INSTALL_BIN} --version"

  if [[ -n "${USER_HOME}" && -d "${USER_HOME}" ]]; then
    echo "complete -C \"${CONSUL_INSTALL_BIN}\" consul" >> "${USER_HOME}/.bashrc"
  fi
}
